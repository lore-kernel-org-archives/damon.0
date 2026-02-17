Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97F923373D;
	Tue, 17 Feb 2026 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771341618; cv=none; b=Q9pDhwFBxa6YNrPC4WG11dyOWlVnL/dUXd2i29/Lpn5zsKQ+Y1xpKn5hTQTRTNvKUFeuMO1ksKJr+ms/4MPt8i46kEDcxoRcPKX0y2oMimMqQ28AhYdZIwNoZEDGqLINdWfML1gBvUuwSoTROckKq8VNpHiLxkeecaB3Z+3Jn7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771341618; c=relaxed/simple;
	bh=RRQQWmjBfu+lhdr5VWOFzsXWEFu8FcRKLvuTLEMmDhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDlytpM6cPcTh46v58CminxbmFaDmWfqS128pueHCzdq+V0Aje+pS1qG+V2di+d7U6Fw1Sx4haQbWZvDwXzZmUXrXciLmO5BOcvdd65vTRHqWD3MxE5SJ+1meLySZv6O+SDqVIl5XioLPm5xakcH9fX2J3Zicbov5ZQ1U53MWWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMTAo2mk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMTAo2mk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D482C4CEF7;
	Tue, 17 Feb 2026 15:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771341618;
	bh=RRQQWmjBfu+lhdr5VWOFzsXWEFu8FcRKLvuTLEMmDhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gMTAo2mkj62tpFpSArZWDz8JTT0Bpr1l0QB6wq0R8kVLQsNHofMo8spcT1KhD2Ez0
	 K7wlNzfNYTQV/RndLPHz00yNDtOukgy95yZz3SEm6kiOvJnrVNrhPr76nHFZMKHbBI
	 rMipOdiFAeviUoiryqudyaAAa0RbvpcGx/1RV3/kG1yWmkhZ1pPnMKIEYxSxCCa8I8
	 icIFUBj0wY7WDoU+xLvBK+u0BWDzYpB+jHHpwq4hMvz2ksXJVgVCDLf+3H2fYHJJWi
	 ombTvTIsxh6mB1GeDHguir5N9aEqYC8Yl/1BKtxUvlrh/p5CxQSwwJ2sw1+bSkY1aB
	 lnHbwG2HztwWQ==
From: SeongJae Park <sj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: SeongJae Park <sj@kernel.org>,
	oe-kbuild-all@lists.linux.dev,
	damon@lists.linux.dev
Subject: Re: [sj:damon/next 130/142] samples/damon/mtier.c:78:30: warning: unused variable 'region'
Date: Tue, 17 Feb 2026 07:20:14 -0800
Message-ID: <20260217152015.80806-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <202602171530.NsLdPVOF-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 17 Feb 2026 15:33:25 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> head:   53a936b437ade97f957569534f1460d23883b94f
> commit: 52639cde20a9887c5df4acc55fb51a4f48a1644d [130/142] samples/damon/mtier: replace damon_add_region() with damon_set_regions()
> config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20260217/202602171530.NsLdPVOF-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 15.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260217/202602171530.NsLdPVOF-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202602171530.NsLdPVOF-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    samples/damon/mtier.c: In function 'damon_sample_mtier_build_ctx':
> >> samples/damon/mtier.c:78:30: warning: unused variable 'region' [-Wunused-variable]
>       78 |         struct damon_region *region;
>          |                              ^~~~~~

Thank you for this report!  I just added a fix for this to my tree.


Thanks,
SJ

[...]
