Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794161232;
	b=JzdMtqvLqGKFCZrHh425QM9tDARC/I0gYtSCQoGaeHDWqLbP0z98ANeSql9WmX2i5jse
	 vtVMVl/Yw8AuM9P0Ypqn/wYFXSysoKkEU9T69oI5V0D3zpbP0B9oz06CrpWXXzBb/H78J
	 YAks9dgiYIM+Dd3RguzUuC/bjG2k0ky797G1Iej0cYPPzWB/trttMMkA5bGStpYNEvThv
	 NbzWk+9xHR+92h877/1yA4NIocOWj3fytusOC3Yl0rVCMFFuPErCUNwDZSTgeLIS8N/PM
	 1u4ODIqah5bDMRbZpTcKqCXT0OwF56bKM03DLZpyeOrubHgZd8ZG+LI3atksP5gwAUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794161232;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KZfft/vBOCrTOsCKT0dA/OkOOQlWI67PZFbELklrrjU=;
	b=zJ624KSMoOB84h7XMTbthEPGHmVmW+v5bPF+J3FbuYL3oq09mGkzmFeSYwV6LD0H1npd
	 Zpqr/Soa2Pn4Eo2iX2e7OZQ1+85dFVwoUwsfrxNG6G8B5ve/xIVyqOsTdMrrws0CNm1A1
	 LjUzlveXEQPVM2gGIU5tG+pJaP0HdBH3UziTblGanh7OZu7c+qyW2QujM496adhFyWPVR
	 pHjoe/JkbpRV9KnmEJInBQqwca5raJb8jkhJRFMxD/Rc9BLfWWPRX16SQjQCGdfVLCt2l
	 uOz8KTWyL6azPNlYl0p0UNY0huKp+SxXIENtckJ3QXg9UPwHlTjzbBa+Gr62fOIy+1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k5HTCQMy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A1C606A320;
	Sun,  8 Nov 2026 18:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k5HTCQMy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B221F0089F;
	Sun,  8 Nov 2026 18:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794161232;
	bh=KZfft/vBOCrTOsCKT0dA/OkOOQlWI67PZFbELklrrjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k5HTCQMyBjX1rKiwurPLmKN6EI2Yz0SbzSi+7Cj4goHw24jeNOV6dH6St1I18Ds2g
	 qbqvwX5xj9gahLQ/esDyLQ4BpJrOd07miafD6CSSAlmiB9bYbTJWOf0lDsRVhfB6Fi
	 AxBYCFoUxwS9bIGjXt++QVBuSAHPHW4MNGcTuRZZUh37ZDSbH2sodgAa2j7xsOS2Cf
	 zs8Wlg4N4RpaSDNxMYL15RlGTBQ0RYiZJPabhQaR9WNDIN3QUEIRV//ejHsAX9G8N0
	 2RbtsvBMFZXwDhLoWKp7OeIo0/tFchf54JxbZP00iTDXmH9q0AVpmm6vH7+YWGo0YV
	 9QPA6xnefKq1A==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/paddr: add KUnit tests for addr_unit conversion
Date: Sun,  8 Nov 2026 10:07:04 -0800
Message-ID: <20261108180705.107130-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109-test-damon-paddr-addr-unit-kunit-v1-1-bd10bb87be98@gmail.com>
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

Hi Aveline,

On Mon, 09 Nov 2026 01:23:46 +1100 Aveline Noir <jm5905938@gmail.com> wrote:

> damon_pa_phys_addr() and damon_pa_core_addr() convert between DAMON core
> addresses and physical addresses using addr_unit.  addr_unit lets 32-bit
> kernels with a 64-bit phys_addr_t monitor physical memory above 4 GiB,
> but no test covers the conversions.
> 
> Add a KUnit suite for both helpers, including a case for addresses above
> 4 GiB that is skipped when phys_addr_t is 32-bit.

Thank you for this patch!

> 
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>
[...]
> --- a/mm/damon/Kconfig
> +++ b/mm/damon/Kconfig
> @@ -65,6 +65,18 @@ config DAMON_VADDR_KUNIT_TEST
>  
>  	  If unsure, say N.
>  
> +config DAMON_PADDR_KUNIT_TEST
> +	bool "Test for DAMON physical address space operations" if !KUNIT_ALL_TESTS

The above line has more than 80 characters.  What about removing "space" ?

Other than that,

Reviewed-by: SJ Park <sj@kernel.org>

Assuming you accept my above suggestion, I modified this patch and applied to
damon/next [1] tree.  I will repost it soon (~1 week) as an mm.git merge
request.  So, no action from your side is needed for now.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
