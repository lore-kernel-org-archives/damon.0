Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6901469D;
	Mon,  9 Feb 2026 17:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770659183; cv=none; b=Z4CBbxYJaIeJn4Adj6wDHRZzoI0K6+Qsg08A77kpJw7Hzb4ZuTXhvSj/Caw53itSqtzsXXGKEDsku9WCn417S+8pOhPOsg+pojDsXCOmo/AkbGjPFsZYrFQcH98glBH9S/q4NLjmob+jl3IX2qrZX4yg2wl7O5Iu0hD27Tu2dcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770659183; c=relaxed/simple;
	bh=5tYHqdOIO9+kNsPGBamZhWPlrPY7zlzhK+s+tLVNB8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qc9lLDf2nLSq3A7jWP5f45AIP9nR75hd7t4hYW+SvQxe2yF6iVJK/lGMyx/gO8VfUYFd+bTgtJdmHoAXqwTcpGJb/+f6yjaEdmn0+ACizHMK/VDydiTFWec/RaaPknR2Eski0CJ0D4AJf1y/Y6jvQZUOjQwowbHWdDMYQrJnrXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6vkucdV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6vkucdV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E1DC116C6;
	Mon,  9 Feb 2026 17:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770659183;
	bh=5tYHqdOIO9+kNsPGBamZhWPlrPY7zlzhK+s+tLVNB8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b6vkucdVe4wrpOv1J2Nc1Ee0STeaMnefAyuePiZysb18efHQFsEkWbBO7RfgbkZuK
	 S7b3GsNEa8HGSlKY5/tTI5+DlNs9iH1Z5anSdYsQixvlx74lfwaOStO2j/iTjJdIVY
	 UWc1/gagg/LckIH9N6bRbo4ajUgaLiFTHHGHQeNH9rDiJ19MY2C8EBm0hSQgImmYIP
	 3IzwsF1BuWekWmo9s8VZwN+7tKexcu9Az3fZWqdYgkJ2IizGn4wctmMTBW8yrKduig
	 i40yNIFOu39xhHLUYBLv5gwEQE6APdW/cOpgYxKPLdQDkdvM69oLzphab9d+d2tuXS
	 1b4ngFgul126Q==
From: SeongJae Park <sj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: SeongJae Park <sj@kernel.org>,
	oe-kbuild-all@lists.linux.dev,
	damon@lists.linux.dev
Subject: Re: [sj:damon/next 112/124] mm/damon/core.c:1862:25: error: 'c' undeclared
Date: Mon,  9 Feb 2026 09:46:20 -0800
Message-ID: <20260209174621.39775-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <202602100155.sDqMXews-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 10 Feb 2026 01:35:06 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> head:   a8c204a2a82057d70dd8944476dd043dc52561ed
> commit: 7fdffc23ed84ea44a9f15f71d15b00a94f326acd [112/124] mm/damon/core: unify damon_warn_fix_nr_accesses_corruption() with damon_verify_reset_aggregated()
> config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20260210/202602100155.sDqMXews-lkp@intel.com/config)
> compiler: sh4-linux-gcc (GCC) 15.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260210/202602100155.sDqMXews-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202602100155.sDqMXews-lkp@intel.com/
> 
> Note: the sj/damon/next HEAD a8c204a2a82057d70dd8944476dd043dc52561ed builds fine.
>       It only hurts bisectability.

Thank you for this report.  Seems this is same to another one, that a fix [1]
has pushed a few hours ago.  I understand it is still making bisect
complicated, because the fix was made as a separate commit.  I will squash the
fix to the broken commit soon.

[1] https://lore.kernel.org/20260209151322.54520-1-sj@kernel.org


Thanks,
SJ

[...]
