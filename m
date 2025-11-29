Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03E43C17;
	Sat, 29 Nov 2025 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764436256; cv=none; b=exzYxO8rmI046FloOSu3ki9WnsO02hfFNjPnMik5g4A6PfTIACajV17AeelRVI1F3G3lgVAhKq1Ci2kLBNaixkWrHrt+yN2yvZg/DXWAzX1vuZquz2/boK367DYP1d8YHjzOlB/wvVOT6V31W3TbheelI8q1UZWNAEhRM9/qSfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764436256; c=relaxed/simple;
	bh=5Jnx6XSyzNl0s1JeoaSpcGapG5gc6IBem2nxCWuxBs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JwLqa5+gK1+scVpwjeg6orGfkBwoPEs+fq0CNIS3owWBilbzsiayuqT2kgE0vSDbg3kQNiAXF0lg7jl/xs2QJxRmH9Z+deACe0xm8W7FE+D4SsYQaUSnKD0cuHv7coCsAkWuG8wBC1mLpknPP8Rt0WU2vmHbfzXylgL6ERxzCns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPqYGgX4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPqYGgX4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0C2C4CEF7;
	Sat, 29 Nov 2025 17:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764436256;
	bh=5Jnx6XSyzNl0s1JeoaSpcGapG5gc6IBem2nxCWuxBs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZPqYGgX47x1JEtwNdjooa4RPPIQwmHQd6WkyXZ4iWi1HMynFopPuMLquKEEE5KDYV
	 x8cZ45ChufmHbSMMHe1rFD03jkCiKv4e2r4EH6SCnTWG8wQ5DA9uKg+7YKD15ZgeX1
	 jSsrRzCBl+P7A7jpbB6lhCwnNVqjcAyJXpkDXEWo9jrfCQJNBlTMPtDJyItQiLvONL
	 f86U4rFMcoulkLpnPnpa1A1a7la4suuyG6ajfyjokrKhN8bZUhycKwED0ZDca7r1x/
	 zzwE3DbFDD7A3i8KU47Aik+vJevr8I3H1Fpui9GCCSzBzR/4zjm4zuPGT8U8ixK8yo
	 TH/fDfoi6N6QQ==
From: SeongJae Park <sj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: SeongJae Park <sj@kernel.org>,
	oe-kbuild-all@lists.linux.dev,
	damon@lists.linux.dev
Subject: Re: [sj:damon/next 101/102] checkpatch: WARNING:REPEATED_WORD: Possible repeated word: 'is'
Date: Sat, 29 Nov 2025 09:10:50 -0800
Message-ID: <20251129171052.48021-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aSrWuUuXhjnUZu2W@rli9-mobl>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 29 Nov 2025 19:19:21 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> head:   09441df640d26cf9228bc68c256ebf1f0e28669d
> commit: 5e3fefed6d95bbe0b2505ad80309debcf09bc439 [101/102] mm/damon: add data structures for access check control
> reproduce: (https://download.01.org/0day-ci/archive/20251129/202511290619.LO76yGtH-lkp@intel.com/reproduce)
> 
> # many are suggestions rather than must-fix
> 
> WARNING:REPEATED_WORD: Possible repeated word: 'is'
> #45: FILE: include/linux/damon.h:862:
> + * @matching:	Whether is is for condition-matching reports.

Thank you for this report, fixed:
http://git.kernel.org/sj/c/dc85bee8bbc5346521716cf1f469e403af219179


Thanks,
SJ

[...]
