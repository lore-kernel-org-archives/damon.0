Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD4D136672;
	Tue,  2 Dec 2025 01:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764637617; cv=none; b=W1aHyXG1c/iOSWBHHfoi4I2jwr7F1tmHjPjrUx9bM0UwLZ/ETh2yQQDvfQEQcVuVCGGFhPh2hsB4AdwzrALyNyw5WwEf7GqhTyUQPakQ33gSCTG3oBYIIL6Khnc3cdbJmnUDpH453KUIRyw5SGOtP2IBsHwcCd1ekFCeAAGHEOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764637617; c=relaxed/simple;
	bh=Jjq8SuepqBFrLbWMv7HAS5lnFc5i5C6b/W/wJCH+GG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Chip1ngpH0Cnm+zad/n1mk6BqZpljRhj0fVVM0GuFeZPTMTDXAMRRvSDf4y06yu/epM4CGvPBWdq6vduyTF9PlvTcqcoe9LPAQTqLSk+fasXQLXIK6ripenF252JNJa+yrthyYTozPZ1M5WIn9M3rLZ290geSYgV8cxaYS6IchU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfZ3vo15; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfZ3vo15"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D737AC4CEF1;
	Tue,  2 Dec 2025 01:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764637617;
	bh=Jjq8SuepqBFrLbWMv7HAS5lnFc5i5C6b/W/wJCH+GG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NfZ3vo15nvOPh8pjC7ubSkFCDa5ZH+Vxc6i7Vq9pIpDnhNLFYBZDoGcNXKlpolZBL
	 3QVzNFLGYZJzsn5H4T0xXChovitptTU0tQv5EoiIfzRnJ94P5cItBeREOoyid2Tr3q
	 5OQ5sEA9O5eT7uZNon996ye/DJXAl+Gnkijr8advnDCdnimLE5W7u+kSrI6Q0YYRYv
	 ZW+kBETJYQkbHTYoEfdRBFKxoyMcTGdQ8XhRt0Krz5zzKuBWaVPTF8MEso8opxPaG0
	 tvH7jrNBLYWFS2XPEW6ID6sVyRTSovOT/2pC6G1sQnQm4wUcIR58+9w/Rm08+WxKxN
	 8Z118+qQGIhEA==
From: SeongJae Park <sj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: SeongJae Park <sj@kernel.org>,
	oe-kbuild@lists.linux.dev,
	damon@lists.linux.dev
Subject: Re: [sj:damon/next 145/145] mm/memory.c:6213:9: error: implicit declaration of function 'damon_report_page_fault'
Date: Mon,  1 Dec 2025 17:06:48 -0800
Message-ID: <20251202010649.71271-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <202512011308.JsZqQIqQ-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 1 Dec 2025 13:19:13 +0800 kernel test robot <lkp@intel.com> wrote:

> :::::: 
> :::::: Manual check reason: "low confidence bisect report"
> :::::: 
> 
> BCC: lkp@intel.com
> CC: oe-kbuild-all@lists.linux.dev
> TO: SeongJae Park <sj@kernel.org>
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> head:   3fdd82439d28bd0bc5eeb347a6e96569ae05ec92
> commit: 3fdd82439d28bd0bc5eeb347a6e96569ae05ec92 [145/145] mm/memory: move fault reporting into damon
> :::::: branch date: 7 hours ago
> :::::: commit date: 7 hours ago
> config: riscv-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20251201/202512011308.JsZqQIqQ-lkp@intel.com/config)
> compiler: riscv64-linux-gcc (GCC) 15.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251201/202512011308.JsZqQIqQ-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/r/202512011308.JsZqQIqQ-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    mm/memory.c: In function 'do_damon_page':
> >> mm/memory.c:6213:9: error: implicit declaration of function 'damon_report_page_fault' [-Wimplicit-function-declaration]
>     6213 |         damon_report_page_fault(vmf, huge_pmd);
>          |         ^~~~~~~~~~~~~~~~~~~~~~~

Thank you for this report!  Seems this happens when COFNIG_DAMON is unset.  I
just pushed a fix:
http://git.kernel.org/sj/c/47b20fdc07850bd8f


Thanks,
SJ

[...]
