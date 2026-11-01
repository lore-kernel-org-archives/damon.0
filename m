Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793548907;
	b=znwLwrEQ7BV2njU/sLCWrtghbr44bLiKH0FtKjX75XZ7thsfB96QuhfY6QoLjSzOi0LV
	 ezH4WYYocsFV1+mEHESwpkFuB+o5RyNp5tISlfEOF5cqUeoeBA6F/ZfH/fmxptAUQZcdy
	 9myJZHRmU8h0TFO/vLbbVEeY2RomnHnUUinmIPvjzCIP3DmuHovDroUnbPrK8j8d1VcSA
	 MWW+oHNjYz0e6XdVujNkvdxee9lFjtnyjyp3w5IHGVuBJws0FJn/92MCp/4iwNORjFSvs
	 LITq4sxeZHyByJlMdlPHDrwJ0j7ewBYCxv8EbI9Q5dV7kCG3pD8IrP597AtAY80uz4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793548907;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Rds4H6dx4b1Y1/1DcN2ykcLQmlq7nhhI7m9hZrgFe7U=;
	b=4LFW5sdet8HvCDnw1BVFoU7A8KCJwOrcHj829UWRPfm2yjQFUj3isYQI1NWGV42cZdkW
	 keBjSV8nf8xRQBNCEFiSA8hK81VHBCt9pzvI5DSTquHZjOnMWLaSlQsgN+qwO2bgXd1e7
	 c+g5yuxwFH3862G6TRr42eIEcP9niesCeUI/6ccFTuqQ31JcKcd9akBNHhew+7Pg/wJ7N
	 JTiCtpgiDH0aUXTr41ZhIhuRlsWpDSLF9jXyFY815SRctD9HyjtBKAbZHHdTOF52OuspD
	 FH/zgol6b+SsomYA6303oe55hf5tdoULRnC/YO9biZX2Ij1l4Vf+pDO9QFoN3BXEx6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xrm8487O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C545606A325;
	Sun,  1 Nov 2026 16:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xrm8487O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A4A1F00A15;
	Sun,  1 Nov 2026 16:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793548906;
	bh=Rds4H6dx4b1Y1/1DcN2ykcLQmlq7nhhI7m9hZrgFe7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xrm8487Ocqu78WL5jN8h4I7d8DoNc2EHlDXaPxlDLInKUzlIwlAbe4HlBevo/8+2k
	 6DEGnYvbUrOFlPAvds0Hx3oiSzZcQf8eaadIcAOsivzPwqCEnbY2Cu7Jd28xqwj06v
	 YcZU0DlLENOlB120BTuezof0tqVpgD/XRYESsof/xD0MRYY21uEE0YFGzkaqCsaU3c
	 5SLGUU8gRA3jqh1NaXu2eUEUysOlNNw5kRiNMncoCJsB+T2d38q9vovFDKiu9xTzQl
	 5uf+Xgw9F50IK5Y/ua28sWweu1hGu47QQTtv/d4gawx/YpyYwBWLbjTAEIn8fUcgnk
	 5AQTF1rTfiSMg==
From: SJ Park <sj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: SJ Park <sj@kernel.org>,
	oe-kbuild-all@lists.linux.dev,
	damon@lists.linux.dev
Subject: Re: [sj:damon/next 41/139] mm/damon/vaddr.c:891:21: error: too few arguments to function 'damos_va_invalid_folio'; expected 2, have 1
Date: Sun,  1 Nov 2026 08:01:39 -0800
Message-ID: <20261101160139.108584-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <202611010354.GdEQgO22-lkp@intel.com>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 01 Nov 2026 04:00:38 +0100 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> head:   7004d750fdd0fe580091136ef098fba296e51863
> commit: 046c68e46b042453c4cdbd909eb4dc448dde6325 [41/139] mm/damon/vaddr: use damos->last_applied for migrate action
> config: csky-randconfig-2000-20261101 (https://download.01.org/0day-ci/archive/20261101/202611010354.GdEQgO22-lkp@intel.com/config)
> compiler: csky-linux-gcc (GCC) 15.3.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261101/202611010354.GdEQgO22-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202611010354.GdEQgO22-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    mm/damon/vaddr.c: In function 'damos_va_migrate_pmd_entry':
> >> mm/damon/vaddr.c:891:21: error: too few arguments to function 'damos_va_invalid_folio'; expected 2, have 1
>      891 |                 if (damos_va_invalid_folio(folio))
>          |                     ^~~~~~~~~~~~~~~~~~~~~~
>    mm/damon/vaddr.c:840:20: note: declared here
>      840 | static inline bool damos_va_invalid_folio(struct folio *folio,
>          |                    ^~~~~~~~~~~~~~~~~~~~~~

Thank you for this report, I just fixed this on my tree and pushed.


Thanks,
SJ

[...]
