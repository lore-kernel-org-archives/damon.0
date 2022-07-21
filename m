Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6340A2567
	for <damon@lists.linux.dev>; Thu, 21 Jul 2022 16:36:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8D4C3411E;
	Thu, 21 Jul 2022 16:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1658421388;
	bh=XVJVoZKd+Ndx59bQZ92vq+nGTEbyf+w5ACr6Hf1HdIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lmk99aFdpPTLZQF+vDTVGeHmavI8Ilm/RC6UoK7WI0uFv6Hy3Tutf/1Xi5zNKwbrS
	 DP+unKBefQhbORp5P0KByK7nP/im+rkvGmy0hccXmOVCmPJIVuSYhI2P3+HIgVH8fL
	 wrMHIEuOsm/TObj7ygXsx5Hcv2acbSNY/eXto/5Qxq5HVOPDJbWWB8/0IJjxBJff6R
	 eH5YDBL5/5HNALmYZsvJYKk6GJ8Swg8fbnjfU3YwCRGB2pNjlkyEWUm0asilhhVFdc
	 za66B8Pvhbfnl2unNf+UgyFNYvFLk1fe8WN626pBItd/RAlhHTfLCZ+WO9gIeF3v9Q
	 HBrEnoJCqq8jQ==
From: SeongJae Park <sj@kernel.org>
To: David Rientjes <rientjes@google.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	gthelen@google.com,
	baolin.wang@linux.alibaba.com,
	xhao@linux.alibaba.com,
	tuhailong@gmail.com,
	wangkefeng.wang@huawei.com,
	tangmeng@uniontech.com,
	hanyihao@vivo.com
Subject: Re: [RFC] A few plans for DAMON sysfs extensions
Date: Thu, 21 Jul 2022 16:36:24 +0000
Message-Id: <20220721163624.89772-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <7b87db1-4016-c5b9-5277-1b39f73b9c71@google.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello David,

On Wed, 20 Jul 2022 18:41:29 -0700 (PDT) David Rientjes <rientjes@google.com> wrote:

> On Thu, 2 Jun 2022, SeongJae Park wrote:
> 
> > Non-root Users
> > --------------
> > 
> > Someone told me they want to use DAMON from non-root user, for the user's
> > processes.  My DAMON sysfs interface extension idea for this usage is adding a
> > special directory under the DAMON sysfs root (/sys/kernel/mm/damon/) as a
> > sibling of the admin/ directory.  The name would be, say, non-root-users/
> > (please blame my bad naming sense and suggest something better).  The non-root
> > users who want to use DAMON would be able to populate a directory under the
> > directory.  Then, the non-root user populated directory will have its files
> > hierarchy same to that of the admin/ directory.  The files will work same to
> > those under admin/ directory but fails when the monitoring target is out of the
> > user's permission.  An example usage would be something like below:
> > 
> >     $ ls /sys/kernel/mm/damon
> >     admin non-root-users
> >     $ cd /sys/kernel/mm/damon/non-root-users
> >     $ mkdir for_my_damon_usage; cd for_my_damon_usage/kdamonds/
> >     $ echo 1 > nr_kdamonds; cd 0/
> >     $ echo 1 > /contexts/nr_contexts
> >     $ echo vaddr > 0/contexts/0/operations
> >     $ echo 1 > 0/contexts/0/targets/nr_targets
> >     $ echo $(pidof my_process) > 0/contexts/0/targets/0/pid_target
> >     $ echo on > state
> > 
> 
> Hi SeongJae,
> 
> Thanks very much for looping us in on this.
> 
> One concern would be the ability of non-root userspace to be able to go 
> off and mkdir under this hierarchy.  It seems like for this to work 
> as described above that root has created a non-root-users directory that 
> anybody can create a directory under and then provision work for a kdamond 
> thread to do.
> 
> Much better might be to require that the admin has to do any mkdir here.  
> It can mkdir a non-root directory and then chown it to the user so that 
> the non-root user can control it (much like a "user subcontainer" for a 
> cgroup hierarchy).

Agreed, that sounds making much more sense and provides better user experience.

> 
> > The files tree would be something like below:
> > 
> >     /sys/kernel/mm/damon/
> >     │ non-root-users/		<- This is the new directory
> >     │ │ for_my_damon_usage/
> >     │ │ │ kdamonds/nr_kdamonds
> >     │ │ │ │ 0/state,pid
> >     │ │ │ ...
> >     │ admin/
> >     │ │ kdamonds/nr_kdamonds
> >     │ │ │ 0/state,pid
> >     │ │ │ │ contexts/nr_contexts
> >     │ │ │ │ │ 0/avail_operations,operations
> >     │ │ │ │ │ │ monitoring_attrs/
> >     │ │ │ │ │ │ │ intervals/sample_us,aggr_us,update_us
> >     │ │ │ │ │ │ │ nr_regions/min,max
> >     │ │ │ │ │ │ targets/nr_targets
> >     │ │ │ │ │ │ │ 0/pid_target
> >     │ │ │ │ │ │ │ │ regions/nr_regions
> >     │ │ │ │ │ │ │ │ │ 0/start,end
> >     │ │ │ │ │ │ │ │ │ ...
> >     │ │ │ │ │ │ │ ...
> >     │ │ │ │ │ │ ...
> >     │ │ │ │ │ ...
> >     │ │ │ ...
> > 
> > No kdamond
> > ----------
> > 
> > Currently, DAMON creates worker kernel threads called kdamond and does
> > requested works on those.  There was a request asking the work to be done on
> > the requester's process for easier resource usage charging.  For this, we could
> > add a new directory under the user-specific DAMON sysfs root directory, called,
> > say, self-service/ (again, blame my bad naming sense please).  It will have
> > files similar to the contexts/ directory.  Then, DAMON code will run on the
> > process that writes 'on' to the 'state' file under the self_service/ directory.
> > 
> 
> For this, the sysfs interface might be getting too complex.  We can 
> imagine hundreds of files that userspace must maintain to implement the 
> full scheme of how it wants to use DAMON.  This allows it to be very 
> configurable, but at the downside of a lot of complexity that must be 
> managed not only in the interface but also in how kdamond must be 
> implemented to support the various combinations.
> 
> So I'd definitely recommend that all possible tunables and configurations 
> are indeed necessary and have real-world use cases behind them that are 
> *generally* useful to everybody.  In other words, hold a high standard for 
> trying to add more tunables under these directories because it becomes 
> very hard, if not impossible, to deprecate this support once the sysfs 
> interface provides them and userspace depend on them.  Something to keep 
> in mind when extending this interface.

Again, fully agreed.  Ideas here are only in brain storming level at the
moment, and would need more discussion with various party to justify the
benefit of the added complexity.  To expedite such discussions, I'm planning an
open, regular, and informal virtual meeting series.  I will announce that soon
as soon as prepared.

Off the topic.  I'm thinking about a sort of auto-tuning mechanism for reducing
the tuning complexity.  For example, TMO[1] idea-based DAMON_RECLAIM
autotuning.  My experiments running a very simplified TMO[2] with
DAMON_LRU_SORT in background reduces some-memory-PSI about 10%.

[1] https://www.pdl.cmu.edu/ftp/NVM/tmo_asplos22.pdf
[2] https://github.com/awslabs/damon-tests/blob/next/perf/runners/back/0009_ttmo.sh


Thanks,
SJ

> 
> > For an example, below files tree is imaginable.
> > 
> >     /sys/kernel/mm/damon/
> >     │ non-root-users/
> >     │ │ for_my_damon_usage/
> >     │ │ │ self_service/			<- This is the new directory
> >     │ │ │ │ state
> >     │ │ │ │ contexts/nr_contexts
> >     │ │ │ │ │ 0/avail_operations,operations
> >     │ │ │ │ │ ...
> >     │ │ │ kdamonds/nr_kdamonds
> >     │ │ │ │ 0/state,pid
> >     │ │ │ ...
> >     │ admin/
> >     │ │ self_service/			<- This is the new directory
> >     │ │ │ state
> >     │ │ │ contexts/nr_contexts
> >     │ │ │ │ 0/avail_operations,operations
> >     │ │ │ │ ...
> >     │ │ kdamonds/nr_kdamonds
> >     │ │ │ 0/state,pid
> >     │ │ │ │ contexts/nr_contexts
> >     │ │ │ │ │ 0/avail_operations,operations
> >     │ │ │ │ │ │ monitoring_attrs/
> >     │ │ │ │ │ │ │ intervals/sample_us,aggr_us,update_us
> >     │ │ │ │ │ │ │ nr_regions/min,max
> >     │ │ │ │ │ │ targets/nr_targets
> >     │ │ │ │ │ │ │ 0/pid_target
> >     │ │ │ │ │ │ │ │ regions/nr_regions
> >     │ │ │ │ │ │ │ │ │ 0/start,end
> >     │ │ │ │ │ │ │ │ │ ...
> >     │ │ │ │ │ │ │ ...
> >     │ │ │ │ │ │ ...
> >     │ │ │ │ │ ...
> >     │ │ │ ...
> > 
> > 
> 
