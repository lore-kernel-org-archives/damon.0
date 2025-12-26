Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FAE135A53;
	Fri, 26 Dec 2025 19:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766777039; cv=none; b=eERWXeXDuiRgPQJmE2FAPg/nh4JyCmx9pYC2KSx3FuxAn9NxUJbOE1UYYdgtuiKmo7tKkm7sEK6eSMlhytSVTXoYNfAL4drJYWlWXHogLb387ytMG96tlvEQHPhjJ2UaHSV/2/z2Isb9fY2yLM/Juox2KbWxEX8sRcQ6j08PNOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766777039; c=relaxed/simple;
	bh=arftM4pHFACLPUVgBSvAbrjbpZi/OEAJGwNcLXz/cac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X38V+TbgnUgu+/HICyQIrs6pGzD2PraJB7oO345T/DxJrw3Hs7HiR0KTH7CL1bRrzgzRhtOWxd1iPyaXPXeRTeksl2/t4AKW1/X8qt+IPVLW+bDOF0cZDXgi3U0UlOGBJ0TG9FWhUmrFOwP0yOpAn7aLPuExvExiFdK/L0WIe+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHCV8tqD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHCV8tqD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FB9C4CEF7;
	Fri, 26 Dec 2025 19:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766777038;
	bh=arftM4pHFACLPUVgBSvAbrjbpZi/OEAJGwNcLXz/cac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UHCV8tqDXxDBwajW4CbneVRvxPst2VwYixAGh5xudZ6mebBfUrdfG67Kze9qc8l4m
	 aAiLN6Tzka7bKK+LtsA1GEnw7ueh4Ws5gONOMWv7h4CQ93X0YC3PrIys1rfK0Wf+PZ
	 Itgoa6jxyggijwD16L1+53v2PKOnN9OuqbwS372OcKhAZdyP0uFLSROPeaADhQqnhX
	 80kdy+6RrZ36GcS2/DfRjeU9py3+q5///wzbvQ9wbr1s0QZ3t/bl9L+TZDCFCS4pLp
	 SsFdD5xKqCT1JZkJ/7AY6NbspL5Sm5Q1Oe7BZJqND64a6H6oREoJzX2xV+/dE9kaTn
	 jYNnF2uaAE5Fg==
From: SeongJae Park <sj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: SeongJae Park <sj@kernel.org>,
	oe-kbuild-all@lists.linux.dev,
	damon@lists.linux.dev
Subject: Re: [sj:damon/next 101/108] mm/memory.c:7487:1: sparse: sparse: symbol 'faults_monitor_controls_lock' was not declared. Should it be static?
Date: Fri, 26 Dec 2025 11:23:54 -0800
Message-ID: <20251226192355.259599-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <202512261908.fhV5eWFj-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 26 Dec 2025 20:00:49 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> head:   777b25c5baaa9e69b7ed0f963d0db781b36776c7
> commit: e874404e9937c662290222d6cd67b7e07b82420a [101/108] mm/memory: implement functions and data structures for page faults monitoring
> config: microblaze-randconfig-r123-20251226 (https://download.01.org/0day-ci/archive/20251226/202512261908.fhV5eWFj-lkp@intel.com/config)
> compiler: microblaze-linux-gcc (GCC) 8.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251226/202512261908.fhV5eWFj-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202512261908.fhV5eWFj-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
> >> mm/memory.c:7487:1: sparse: sparse: symbol 'faults_monitor_controls_lock' was not declared. Should it be static?

Thank you for the report, just pushed a fix:
http://git.kernel.org/sj/c/1d3e0ce41f6d


Thanks,
SJ

[...]
