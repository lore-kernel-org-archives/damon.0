Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83CA363
	for <damon@lists.linux.dev>; Thu,  2 Jun 2022 00:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F564C385A5;
	Thu,  2 Jun 2022 00:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654129785;
	bh=m4oEfhxQTXPmoMY4HHwSuya7LlnSqrJVT8+aHs3oopE=;
	h=From:To:Cc:Subject:Date:From;
	b=SS3PQ5x32AT8io0bgECevjHxhvilcYsfETjv5xsnQdrGAa0POzJ7AQQ0SqaFtB032
	 WFlL3NeGtpn+4KemMuddVwN8a0hloM+I6DAvXLgC5P/PSvHyq6rCaf7C1MgrlZuB9i
	 H+v9Wi55+Zklnp76arn2z1H+FM/pkhE11Oam+RCLtK6drZss6WTfN56NBGLxPTa8HO
	 XYAOvWJ1VRZ4xj4g9bTf3MWWVO6hvYP1znQPBQjT5/NIzlK4C9jXhqmJ0v4E4RRfDn
	 KS+jEKpIVZeolMeTyrqd63dvK1y9SAC5GZx9IsapUognvChrLuLkZLYel8gIHGvRfc
	 2T9U5E8v/1veA==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: rientjes@google.com,
	gthelen@google.com,
	baolin.wang@linux.alibaba.com,
	xhao@linux.alibaba.com,
	tuhailong@gmail.com,
	wangkefeng.wang@huawei.com,
	tangmeng@uniontech.com,
	hanyihao@vivo.com
Subject: [RFC] A few plans for DAMON sysfs extensions
Date: Thu,  2 Jun 2022 00:29:35 +0000
Message-Id: <20220602002935.62334-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello all,


I have discussed with several people about how they want to use DAMON for their
specific use cases.  For supporting those in perfectly optimal way, we might
need to make yet another user interface.  However, IMHO, almost all of the use
cases could be covered by extending DAMON sysfs interface[1].  Hence, I'd like
to share my rough and humble ideas here.  It would be great if you could give
some comments.

[1] https://docs.kernel.org/admin-guide/mm/damon/usage.html#sysfs-interface

Non-root Users
--------------

Someone told me they want to use DAMON from non-root user, for the user's
processes.  My DAMON sysfs interface extension idea for this usage is adding a
special directory under the DAMON sysfs root (/sys/kernel/mm/damon/) as a
sibling of the admin/ directory.  The name would be, say, non-root-users/
(please blame my bad naming sense and suggest something better).  The non-root
users who want to use DAMON would be able to populate a directory under the
directory.  Then, the non-root user populated directory will have its files
hierarchy same to that of the admin/ directory.  The files will work same to
those under admin/ directory but fails when the monitoring target is out of the
user's permission.  An example usage would be something like below:

    $ ls /sys/kernel/mm/damon
    admin non-root-users
    $ cd /sys/kernel/mm/damon/non-root-users
    $ mkdir for_my_damon_usage; cd for_my_damon_usage/kdamonds/
    $ echo 1 > nr_kdamonds; cd 0/
    $ echo 1 > /contexts/nr_contexts
    $ echo vaddr > 0/contexts/0/operations
    $ echo 1 > 0/contexts/0/targets/nr_targets
    $ echo $(pidof my_process) > 0/contexts/0/targets/0/pid_target
    $ echo on > state

The files tree would be something like below:

    /sys/kernel/mm/damon/
    │ non-root-users/		<- This is the new directory
    │ │ for_my_damon_usage/
    │ │ │ kdamonds/nr_kdamonds
    │ │ │ │ 0/state,pid
    │ │ │ ...
    │ admin/
    │ │ kdamonds/nr_kdamonds
    │ │ │ 0/state,pid
    │ │ │ │ contexts/nr_contexts
    │ │ │ │ │ 0/avail_operations,operations
    │ │ │ │ │ │ monitoring_attrs/
    │ │ │ │ │ │ │ intervals/sample_us,aggr_us,update_us
    │ │ │ │ │ │ │ nr_regions/min,max
    │ │ │ │ │ │ targets/nr_targets
    │ │ │ │ │ │ │ 0/pid_target
    │ │ │ │ │ │ │ │ regions/nr_regions
    │ │ │ │ │ │ │ │ │ 0/start,end
    │ │ │ │ │ │ │ │ │ ...
    │ │ │ │ │ │ │ ...
    │ │ │ │ │ │ ...
    │ │ │ │ │ ...
    │ │ │ ...

No kdamond
----------

Currently, DAMON creates worker kernel threads called kdamond and does
requested works on those.  There was a request asking the work to be done on
the requester's process for easier resource usage charging.  For this, we could
add a new directory under the user-specific DAMON sysfs root directory, called,
say, self-service/ (again, blame my bad naming sense please).  It will have
files similar to the contexts/ directory.  Then, DAMON code will run on the
process that writes 'on' to the 'state' file under the self_service/ directory.

For an example, below files tree is imaginable.

    /sys/kernel/mm/damon/
    │ non-root-users/
    │ │ for_my_damon_usage/
    │ │ │ self_service/			<- This is the new directory
    │ │ │ │ state
    │ │ │ │ contexts/nr_contexts
    │ │ │ │ │ 0/avail_operations,operations
    │ │ │ │ │ ...
    │ │ │ kdamonds/nr_kdamonds
    │ │ │ │ 0/state,pid
    │ │ │ ...
    │ admin/
    │ │ self_service/			<- This is the new directory
    │ │ │ state
    │ │ │ contexts/nr_contexts
    │ │ │ │ 0/avail_operations,operations
    │ │ │ │ ...
    │ │ kdamonds/nr_kdamonds
    │ │ │ 0/state,pid
    │ │ │ │ contexts/nr_contexts
    │ │ │ │ │ 0/avail_operations,operations
    │ │ │ │ │ │ monitoring_attrs/
    │ │ │ │ │ │ │ intervals/sample_us,aggr_us,update_us
    │ │ │ │ │ │ │ nr_regions/min,max
    │ │ │ │ │ │ targets/nr_targets
    │ │ │ │ │ │ │ 0/pid_target
    │ │ │ │ │ │ │ │ regions/nr_regions
    │ │ │ │ │ │ │ │ │ 0/start,end
    │ │ │ │ │ │ │ │ │ ...
    │ │ │ │ │ │ │ ...
    │ │ │ │ │ │ ...
    │ │ │ │ │ ...
    │ │ │ ...


Efficient Monitoring Results Collection
---------------------------------------

Currently, damon:damon_aggregated tracepoint is the only way to get the DAMON
monitoring results in full.  I heard some users don't want to get the full
results, but only the monitoring results of specific address range having
special access pattern.  For the use case, the tracepoint is inefficient.

DAMON sysfs already provides some of the results via the stats/ directory under
scheme directory, though.  We could further extend it for more efficient and
more detailed results collection.  The idea is, adding a file under each scheme
directory, say, report_the_detail.  Writing Y to the file will create a
directory called, say, 'report'.  The file will have files similar to that
under 'targets/<N>/regions/', and have contents that represents monitoring
results of the address ranges that fulfills the scheme's target access pattern.

For example, below hierarchy is imaginable.

    /sys/kernel/mm/damon/admin
    │ kdamonds/nr_kdamonds
    │ │ 0/state,pid
    │ │ │ contexts/nr_contexts
    │ │ │ │ 0/avail_operations,operations
    │ │ │ │ │ monitoring_attrs/
    │ │ │ │ │ │ intervals/sample_us,aggr_us,update_us
    │ │ │ │ │ │ nr_regions/min,max
    │ │ │ │ │ targets/nr_targets
    │ │ │ │ │ │ 0/pid_target
    │ │ │ │ │ │ │ regions/nr_regions
    │ │ │ │ │ │ │ │ 0/start,end
    │ │ │ │ │ │ │ │ ...
    │ │ │ │ │ │ ...
    │ │ │ │ │ schemes/nr_schemes
    │ │ │ │ │ │ 0/action
    │ │ │ │ │ │ │ report_the_detail	<- this is the new file
    │ │ │ │ │ │ │ report/		<- this is the new directory
    │ │ │ │ │ │ │ │ regions/nr_regions  <- nr_regions would be read-only
    │ │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age
    │ │ │ │ │ │ │ │ │ ...
    │ │ │ │ │ │ │ access_pattern/
    │ │ │ │ │ │ │ │ sz/min,max
    │ │ │ │ │ │ │ │ nr_accesses/min,max
    │ │ │ │ │ │ │ │ age/min,max
    │ │ │ │ │ │ │ quotas/ms,bytes,reset_interval_ms
    │ │ │ │ │ │ │ │ weights/sz_permil,nr_accesses_permil,age_permil
    │ │ │ │ │ │ │ watermarks/metric,interval_us,high,mid,low
    │ │ │ │ │ │ │ stats/nr_tried,sz_tried,nr_applied,sz_applied,qt_exceeds
    │ │ │ │ │ │ ...
    │ │ │ │ ...
    │ │ ...

As I told at the beginning, these are just my rough and humble ideas, and there
could be some important things I'm missing.  Also, I don't have ETAs for each
of the plans, but currently have biggest interest in the efficient monitoring
results collection.  All are in my TODO list, though.  All questions, comments,
and suggestons are welcome as always!


Thanks,
SJ
