Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AF64502F;
	Tue, 22 Jul 2025 06:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753164310; cv=none; b=Q1OQhnbut/0iEnXjcQ4gTq2+GkimzIc/CbrSmoKGb0dH2XmgbtcSFyaihZsuv34N55WlP88rc+/sUhCGlwQXpHrVhPUyNN0v+xpnWAETIJBYVWGA/vf6dlDnzYVF1dcY0LQEC9SJSuj9WUzJoLONNMjRUzJpjP6OZ2cjg+Jzkro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753164310; c=relaxed/simple;
	bh=F134i57yThMGkReks3hjElxUss2HLVKAnAIFuY7jQ0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o7v5yvtLgt+R9gvAJWIBeHI2cJJQ75mOYslezs7Q+OJCNYF+TuYP3dwQXIDbMm/OD1qOD82DAUVbCb8A26Jgczv+d24X10xKBJycm/tO6GCq+wX5jL9NNkLCNvw9RFb9hCJbRoeQ87la6hDYKN3I0bepZC4SxXh7D56ECJApn50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYfk9ddf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYfk9ddf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432BBC4CEEB;
	Tue, 22 Jul 2025 06:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753164309;
	bh=F134i57yThMGkReks3hjElxUss2HLVKAnAIFuY7jQ0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZYfk9ddfFwsuAZUSdq0PnLLV9IqxxB3vO44fsKlyRJ3eK5koOvZ5xVgpsHhmBIMI5
	 yMoKPCcjyyyRAdDelkmmPF2gpBoAmIeH9Rf+Vaw1KozDPOkUDbFeCTUE2iZXRwPE0i
	 NVB+aZ5WyeEK7QO1dDEcRLbCEbl9iZRXpxZuKagZcjzPbNG3XphQPCQb9dkttTsSvp
	 MpInKMkZ3Rut53qZAVHQxpqAWZyKfimTVZdtXDkwom23jSg9eTsgJDtn8Kj4UqiHg4
	 0YO+b93RQuwYPThTPwdkH8pz2bq9bkdmYHkm2nkErTJ1G9lmqTAZgG4MNH0a8trm/3
	 0mR7uQAu2Jknw==
From: SeongJae Park <sj@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: SeongJae Park <sj@kernel.org>,
	oe-lkp@lists.linux.dev,
	lkp@intel.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [linux-next:master] [selftests/damon]  4ece018976: kernel-selftests.damon.sysfs.py.fail
Date: Mon, 21 Jul 2025 23:05:06 -0700
Message-Id: <20250722060506.56112-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <202507220707.9c5d6247-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 22 Jul 2025 13:36:02 +0800 kernel test robot <oliver.sang@intel.com> wrote:

> 
> 
> Hello,
> 
> kernel test robot noticed "kernel-selftests.damon.sysfs.py.fail" on:
> 
> commit: 4ece01897627ddeefcede4ac709cd99763994dc4 ("selftests/damon: add python and drgn-based DAMON sysfs test")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> [test failed on linux-next/master d086c886ceb9f59dea6c3a9dae7eb89e780a20c9]
> 
> in testcase: kernel-selftests
> version: kernel-selftests-x86_64-7ff71e6d9239-1_20250215
> with following parameters:
> 
> 	group: damon
> 
> 
> config: x86_64-rhel-9.4-kselftests
> compiler: gcc-12
> test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> besides the failure of this new added test, we also noticed below tests failed
> while passing on parent.
> 
> e227472ebf00b6b5 4ece01897627ddeefcede4ac709
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :6          100%           6:6     kernel-selftests.damon.damon_nr_regions.py.fail
>            :6          100%           6:6     kernel-selftests.damon.damos_quota.py.fail
>            :6          100%           6:6     kernel-selftests.damon.damos_quota_goal.py.fail
>            :6          100%           6:6     kernel-selftests.damon.damos_tried_regions.py.fail
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202507220707.9c5d6247-lkp@intel.com
> 
> 
> 
> # timeout set to 300
> # selftests: damon: sysfs.py
> # Traceback (most recent call last):
> #   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-4ece01897627ddeefcede4ac709cd99763994dc4/tools/testing/selftests/damon/./sysfs.py", line 42, in <module>
> #     main()
> #   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-4ece01897627ddeefcede4ac709cd99763994dc4/tools/testing/selftests/damon/./sysfs.py", line 31, in main
> #     status, err = dump_damon_status_dict(kdamonds.kdamonds[0].pid)
> #                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> #   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-4ece01897627ddeefcede4ac709cd99763994dc4/tools/testing/selftests/damon/./sysfs.py", line 13, in dump_damon_status_dict
> #     rc = subprocess.call(['drgn', dump_script, pid, 'damon_dump_output'],
> #          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> #   File "/usr/lib/python3.11/subprocess.py", line 389, in call
> #     with Popen(*popenargs, **kwargs) as p:
> #          ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> #   File "/usr/lib/python3.11/subprocess.py", line 1024, in __init__
> #     self._execute_child(args, executable, preexec_fn, close_fds,
> #   File "/usr/lib/python3.11/subprocess.py", line 1901, in _execute_child
> #     raise child_exception_type(errno_num, err_msg, err_filename)
> # FileNotFoundError: [Errno 2] No such file or directory: 'drgn'
> not ok 2 selftests: damon: sysfs.py # exit=1

Thank you for this report!  I just posted a fix:
https://lore.kernel.org/20250722060330.56068-1-sj@kernel.org


Thanks,
SJ

[...]
