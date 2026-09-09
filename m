Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395A1492E5D
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 00:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788913466; cv=none; b=dXthHfsu/qBVQcRzJBgYNEafHy4nC7wyDgfALyKLy5el1q6EIG+3Mc4Z8dPuSr+WHQPAKOK2KGxzSNoedyRdLQD8MXALRzLTtpVMpc/fAdn5sS+ANTz/mgLpJMeIXVtObr1848Qn04Ubp1yZLySXGOftkdwdZfICYITcHGHJnuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788913466; c=relaxed/simple;
	bh=z4zMmpSJsPYe9WzeUa2CxParJlsibiD0I0ZVPGVK/Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rJlKTmFugekAdIvMJ0uUwJR0ayVhmqDCoM8dEaInEb4WuBbktEAW5Meu/AdxvNh39Teih9kx6CymO2eP1IX/ZfEXTXiGi9BYQaJfLK+ANLY5Z3BHYu4eFLCA7r3N8pTPr1cLWHLc7WkX03sQT+ILuoboYckf3Qqe41ow45ECTC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAOx6t+n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAOx6t+n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E0E1F00A3A;
	Wed,  9 Sep 2026 00:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788913464;
	bh=LAEFtICJHIqUC4FM3nbTOtzpBR/BNCiABESPCrtleJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZAOx6t+n66Z4lQ8nxcBtR+SK+kZcbDN1iU08juVASwUMhaC0NKKW/tJDm8VfNILF1
	 oyTFtYJfxOWZfPV+GIHLUeMS9I5wbbo+3uoh0OtpkOdfLzK6fDN5KrJMXmZyfqCegT
	 A3NkyjgscfK09C9j9frLjlQj5hezgvvPXspBLZCwh3lv7ikksKNc8v72oBTnKTHa9r
	 HlqanomDGA8Yw8Mhbx5Y6Vu2av7peqToML7+LGntBYOTCiHaIFvPdSkP3rVcbrRvYl
	 30HpePQHEYx3lw0VE1IA+IAzNJbaa5p1h19TsYSePaMTu92kIjTdX6dVTqZSBObU4D
	 8Zh2zl6eG1SZw==
From: SJ Park <sj@kernel.org>
To: "Eva Kurchatova" <eva.kurchatova@virtuozzo.com>
Cc: SJ Park <sj@kernel.org>,
	sashiko-bot@kernel.org,
	damon@lists.linux.dev
Subject: Re: [PATCH] selftests: damon: add script dir to sys.path for PYTHONSAFEPATH compatibility
Date: Tue,  8 Sep 2026 17:24:16 -0700
Message-ID: <20260909002417.112320-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260908214818.355E91F00A3A@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Eva,

On Tue, 08 Sep 2026 21:48:17 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The patch claims to fix PYTHONSAFEPATH compatibility for all DAMON Python selftests, but misses 3 test scripts, leading to an incomplete fix and a commit message mismatch.
> --
> 
> commit 3a3c43c4b8c811027e52bf0fa5b68c48216e86c4
> Author: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
> 
> selftests: damon: add script dir to sys.path for PYTHONSAFEPATH compatibility
> 
> This commit adds the script's directory to sys.path for several DAMON Python
> selftests to fix ModuleNotFoundError issues when running under Python's safe
> path mode. It claims to fix all 7 tests that import the _damon_sysfs helper
> module.
> 
> >     This breaks all 7 DAMON Python selftests that import the _damon_sysfs
> >     helper module located in the same directory:
> 
> [Severity: Medium]
> Are there more than 7 tests affected by this? It looks like sysfs.py,
> sysfs_refresh.py, and sysfs_no_op_commit_break.py in
> tools/testing/selftests/damon/ also import _damon_sysfs but lack the
> sys.path.append() workaround introduced in this commit.
> 
> If these tests are run with PYTHONSAFEPATH set in the environment or with -P
> on the interpreter command line, will they continue to fail with a
> ModuleNotFoundError?

I think this is not a blocker of your patch, but could you please confirm if
Sashiko's finding is correct, and if you have a plan to fix those in future?

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260908214238.2680324-1-eva.kurchatova@virtuozzo.com?part=1
> 


Thanks,
SJ
