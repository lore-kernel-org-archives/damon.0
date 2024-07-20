Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE4F14A9D
	for <damon@lists.linux.dev>; Sat, 20 Jul 2024 19:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721504315; cv=none; b=jYmglvTgzXl1fH+CaxU+vGx1trChRkYVCLnAvlPw0wdwXGtbVcZq3PKgrWHTIuEyKYHLEyFo/Hh0j7RZUirtiXi1HWaDyyPHRVbso0rQjAdloOFRdzYQaypwK8sfkSm0eZWQMielOeaEwSh66YJozTfYfOsXJkxW5jBSFEOUfi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721504315; c=relaxed/simple;
	bh=tzeodoxvMIRXYE8MFHv9hpbU+iyL+Xfyh15QxMtXswU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sd5Ogl7CHIIz1jM3YYS0A0i40huWgrFcr7iLaYlwsMC9FK54qQMyNNqHM593ryU0W5ygbAvSK0/IBCqmXSGkQ7mnVMfNicedn2dZ06OuptU6SsBi6QKZ4ihnEdHUfZaZYQIiYbMqJA1AyLaB4ZYQ//6wvwkAJLmy3GHus53J3+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8huetym; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8huetym"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BA1C2BD10;
	Sat, 20 Jul 2024 19:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721504315;
	bh=tzeodoxvMIRXYE8MFHv9hpbU+iyL+Xfyh15QxMtXswU=;
	h=From:To:Cc:Subject:Date:From;
	b=G8huetym0z0lIve0nvMWfXlb4yFZ61JO+rrRWH2P+Up12RzwJpVczVS6ke0LFX2g8
	 q9U2szNt9i+VM9NbxNbzinwZ8fPujU1fvsYK0Hb34hSAAwxm1fbCh8fDvNG569GIaa
	 jrEUDuAEsy6dLHOn1imuOu9scNillw3tDqpqO7cIJpDW3K3kS/3YoxyhNqlFd/fDd/
	 bcDvNb4OrkxwEH6+8sVisLUftYtvdP9PZ/iBJ1JXOqJ36Ax9PdElba73PqTLmjYmLH
	 tz8Q+o4Dfy4yMc3I9HR/xINiXLw+K/tOYfD5/9ZVzZ6sWhVe0JInSb9H7Zx1587fqt
	 3oSQXLr6DzGXw==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>
Subject: Fwd: Re: [sj:damon/next 53/55] mm/damon/tests/core-kunit.h:394:undefined reference to `kunit_binary_assert_format'
Date: Sat, 20 Jul 2024 12:38:31 -0700
Message-Id: <20240720193831.340311-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forwarding below to DAMON maling list.

=== >8 ===
From: SeongJae Park <sj@kernel.org>
To: kernel test robot <lkp@intel.com>
CC: SeongJae Park <sj@kernel.org>, oe-kbuild-all@lists.linux.dev
Subject: Re: [sj:damon/next 53/55] mm/damon/tests/core-kunit.h:394:undefined reference to `kunit_binary_assert_format'
Message-Id: <20240720182846.338785-1-sj@kernel.org>
In-Reply-To: <202407202132.JxTrdrIU-lkp@intel.com>
Date: Sat, 20 Jul 2024 11:28:45 -0700
Local-Date: 2024-07-20 11:28:45-07:00

Hello,

On Sat, 20 Jul 2024 21:40:37 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> head:   8fc85b06e0de8c68ae3886178818c03d6eced514
> commit: dfbce92b00bf8691cb86026352354792271c39f5 [53/55] mm/damon/tests: Rename test files to have _kunit suffix
> config: i386-randconfig-015-20240720 (https://download.01.org/0day-ci/archive/20240720/202407202132.JxTrdrIU-lkp@intel.com/config)
> compiler: gcc-12 (Ubuntu 12.3.0-9ubuntu2) 12.3.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240720/202407202132.JxTrdrIU-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202407202132.JxTrdrIU-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    ld: mm/damon/core.o: in function `damon_test_moving_sum':
> >> mm/damon/tests/core-kunit.h:394:(.text+0x9c5): undefined reference to `kunit_binary_assert_format'
> >> ld: mm/damon/tests/core-kunit.h:394:(.text+0x9d3): undefined reference to `__kunit_do_failed_assertion'
[...]

Thank you for this report!

The commit that you found actually introduces the errors, but that's just
renaming the files, which changed the error texts.  Seems the real root cause
of the errors are commit 06463781fa14 ("mm/damon/Kconfig: select DAMON modules
to test when test config is set").

Pushed the fix with more detailed root causes description.
- damon/next tree: https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git/commit/?h=damon/next&id=c3004f235d68aa890660b532b04714a40abafd78
- damon/next patches queue: https://git.kernel.org/pub/scm/linux/kernel/git/sj/damon-hack.git/commit/?id=63b91243a4c3e57262ce92e82d964f4dde26cbc6


Thanks,
SJ
