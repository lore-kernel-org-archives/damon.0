Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794763773;
	b=HuF0XbxWFLPHjsKuXlpFmCzOMKr/N8CUxM45u7HWknclJN8aWvbyZb6A16hHt9In5Fx/
	 dK2keobh2VGsSg4cpJmE6oQMqSoho6BSRBor7/QLRoOmuwTjPmy3e6iim9NiiubNAt9RE
	 +V5r3u4twqV83zWKBO+juMUrXrHQpAbM12CQvZJbe+ZUfJZXcWoyDw6Ylt/BXQnckrtv0
	 k5+I0aFL4MzeST2lV7B7SAGcZimrP6+4ghUDU9C5iGqf4Jpo8vuF4ZOnHls1G9GSf2zkE
	 Zw9VqnMvv6HYkNFM83Vv2c7XwCcfEJYFF0BliGKnoEsYyAKvH6hElP3LaKY1Uqu3W9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794763773;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UzsPgLIU+sooLMnPzcYi0muGH1V9TV21ckVkYTTSwiA=;
	b=KKzz1hzVdJ6OtimjKBSS33WT+YFAfEAfmWy6cqAdXcG3/4Wj80eADwsDCozuMdUbVUJ4
	 652MXr0w9mgsdBE6qUSvIefTO12MEb4Fjya3EteCIVkEV3TrhLCoHndEg6min4H/hfJOd
	 ri57ZoMfu6ywIMMlWG6ZMgSKU/ZL3dha7h261qhzT5im2n5wFX9vJZxPtZY4Z23UmZFjj
	 nTU0JrYg+KWzvQ3MmPJIidLwzE9mRYktxFnHufd/Koip/vj5Hw+T+489X4NV8kGeHvwgn
	 n/g72Gf9PIU+wqJF4T4iC5WbadfwERU6IiV/TXH+OVc9sILjsi/ujreXT1mJVXFHQQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FlfaPaI8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC10C606A31A;
	Sun, 15 Nov 2026 17:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FlfaPaI8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FE61F000C9;
	Sun, 15 Nov 2026 17:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794763773;
	bh=UzsPgLIU+sooLMnPzcYi0muGH1V9TV21ckVkYTTSwiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FlfaPaI844FEyQ6iJqQxw2r+UmOq0LMzlE8A9OLF6pgGmr6zxbw7u6Db70bL0EOVV
	 aZh3dl6uvOKHP4jO1yT9uEKnAptf6Y0wM/DFtg2US2QtsI8skondznfIuu3YgbJwKk
	 HKGqk/QJmpSTKgCmE2tyADtXmKzWcpIsbbAmDX4BeC4ERSTa6gr/fjlhHmxdiZelGw
	 Y09NMzzHRTBhR82lyomTZ+CbbfNWx9syvzQx0sgZ3f5k32PGbELdiW1euUSCQV7/D3
	 Y9O1BDNs/pf47qL/EJuwpowFryKn4qAayBfkxw2OWeB4l4bO8z7ggrEkiba6YyG7S5
	 LxwB/6ThbzyLg==
From: SJ Park <sj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: SJ Park <sj@kernel.org>,
	oe-kbuild-all@lists.linux.dev,
	damon@lists.linux.dev
Subject: Re: [sj:damon/next 37/125] mm/damon/core.c:1839:2: warning: unannotated fall-through between switch labels
Date: Sun, 15 Nov 2026 09:29:25 -0800
Message-ID: <20261115172926.82234-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <202611150922.CN5lOX66-lkp@intel.com>
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

On Sun, 15 Nov 2026 09:33:12 +0100 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> head:   c6e08f98976018ef8823a44dfabbfa444fdc39da
> commit: 0e9dffb2f36016e675b02bf66467ef5b4fc8ed63 [37/125] mm/damon/core: introduce DAMON_FILTER_TYPE_REPORT_MADE
> config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20261115/202611150922.CN5lOX66-lkp@intel.com/config)
> compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
> rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261115/202611150922.CN5lOX66-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202611150922.CN5lOX66-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> mm/damon/core.c:1839:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
>     1839 |         default:
>          |         ^
>    mm/damon/core.c:1839:2: note: insert 'break;' to avoid fall-through
>     1839 |         default:
>          |         ^
>          |         break; 
>    1 warning generated.

Thank you for this report!  I pushed a fix to damon/next.


Thanks,
SJ

[...]
