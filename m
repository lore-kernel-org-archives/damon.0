Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68793B636C
	for <damon@lists.linux.dev>; Fri,  2 Oct 2026 18:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790965740; cv=none; b=RrobthPnPD70xbTLg/lvYSRX3RdJDeImRbwlOCyY/zYHAij3gG0rJiTYRpBzrReKlck4k8NQPrYYtc0lGCdTtm+nWdO51lygCNiY49ANUMBiDs6013KN/HKQSuIXOd6OhybDEYCH522+N/yKLhIrtZxYi29SQenRGI+FXPXCRoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790965740; c=relaxed/simple;
	bh=5Sl2JcBwSl2/nHPxJT7b/cOrI1RzRK/FtdGHgb/dJBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvjEb9ZbUCenPyRK1nbbHnpssswZuMT5dtJl3wiR9QcmM63i0wAuOZdwavkkZa3BMruifR/lKunxspwrdUDvHJuKK/cIhNx0T7VF38mg2r5J2Y5ecgpxG6hium0OZuP/6OZetSk94WBjaEeFzIkNEHUUuM0Vy9Ib/r7pZ1NOYTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=m77IoyDD; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="m77IoyDD"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49d05d51553so675575e9.2
        for <damon@lists.linux.dev>; Fri, 02 Oct 2026 11:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790965733; x=1791570533; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yop7qOc5hOSleMKDtWQuK9wi6ARl8ykYetb7shbGu2Q=;
        b=m77IoyDDZ/Tw3N/awUMBPFyAMmrnfJNIpGvWIuAlHUE6U0oVwq4mLpxRud3MtilR5E
         6EhRHQzczCIiLewjnFdO26tbCVYa1lFADa0vCz7YzYXoNWRWPHWI9yyHXVFN51jJc3Hu
         9k3h8ctEPyNYrnEHVJqd0GB16rpRUk3VO4GcmyOc/PYxKFyaPUmHs4MWUa/jQP+uOa/m
         68ncQqSpvpB7yOLp1Bmr+vdySLaxmVCcpyFE80ZEpcLMsdMwuSRuz+rR8CoV7pYQ7tgO
         DDOOIBs32vrxlyJNbHrZk6AjdF7RHFtNRu5mZzEgMQFB8MqGjBKa5Q+9LkjS8bbNIllK
         Xg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790965733; x=1791570533;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yop7qOc5hOSleMKDtWQuK9wi6ARl8ykYetb7shbGu2Q=;
        b=hvCYgjbXUlHPJTCeQtKGssAkrviwD3OVmq09+MrQ7kIV9JbDc6F8jyDNWl3UdBfVZ9
         5ClEIUdqtP7ZP5MnvjLCl0eGkvfxLNFPeKofbGyYXCT3NVn5c76ip+sOiOxy3t3dABOF
         YkoNgl+i6mHoBgshDGNtWoGdL+ww8S6gEtYw6K1shWE5Goq177loUxK/BM85AHrINuis
         pIpg7cCOJiDl4ToCk2/bEblYCX3GfPYzxLQ7pkzxuWJvMiklgKB26fpp5SItEIVwJkx4
         6ZHlcROmNQdnbogfGwuzwDEcK+4H/w4Nn1e6vOv7+gEa7f+pTpOtX33M57XObCoAudcx
         40jw==
X-Gm-Message-State: AFuF++nhPP5O1tEW/UDsxH1uXRP1VeR3eeUFkgv4bD8ue0NwP/G0eQ7r
	fuTlmACWIBgA0ZbbZlAp0iv8DUdXnXdiD4gr9o3kljBIM8fFcm8iLcK00HS28vHDl2U=
X-Gm-Gg: AYBFou2sPKCJSDb5M2NOgEXT4EXqo8Th7m1MJwwsMH8Fi1N5lOvpXdhDzZFwNO3SaLV
	fXXHVXBFRfckL9CymGmDchbGbxG1RpJZpd1FVqCACx1jiqNjYqNfdhWMkAETSPega1glrB/ySjF
	LkUO/Zmt+jkdUiw1VQJVbudT1XWorRVAEowKacg/NWuDkywcosyBOiHUz2L9RASYCyF4nFEczNy
	3lbqtZQqEOl2vRxUscp8gPsW4/5BWaGCUzwuMvfVI9fsh14F/9fucpEh2lDmiSF71JeuXAIAIJN
	GML+0yPkw5tmDUnIJiZEQlrwZ2JM3eNFKeDo3jX3Rk3ccnB8MgGcBJ+xO2w3fDh7Vl/M5xAJP8Y
	uLJol5C7jOANaLCuQW2s4cV3pCy7wb8p3mZjpJ1yYgT5iEx5zODvHmC+mqPrNGFPB8adQA9XhrH
	vlyeeKlPcYCR4oSx/TRuRBmSiOKXSKV3z+CWPc+cg6/UaqQW/weTr0ZrU2Mx8N6T59Xds=
X-Received: by 2002:a05:600c:3c98:b0:4a0:37d:9e21 with SMTP id 5b1f17b1804b1-4a168101d2dmr5201745e9.29.1790965733358;
        Fri, 02 Oct 2026 11:28:53 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c092:500::7:9b19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b380f0858sm8166687f8f.8.2026.10.02.11.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 11:28:52 -0700 (PDT)
Date: Fri, 2 Oct 2026 14:28:51 -0400
From: Gregory Price <gourry@gourry.net>
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, akpm@linux-foundation.org
Subject: Re: [PATCH] mm/damon: use damon_get_monitor_folio() for hugetlb
 entries
Message-ID: <ar_3r2fNKNRjmzjP@gourry-fedora-PF4VCD3F>
References: <20261002140727.701709-1-gourry@gourry.net>
 <20261002181136.46472-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002181136.46472-1-sj@kernel.org>

On Fri, Oct 02, 2026 at 11:11:35AM -0700, SJ Park wrote:
> Hello Gregory,
> 
> This patch is applied to damon/next [1] tree.  If this patch is not added to
> mm.git in short term (~1 week?), I will ask mm.git maintainer (Andrew Morton)
> to pick this.  So, no action from your side is needed for now.  If it seems I
> also forgot doing that or you cannot wait for my action, please feel free to
> ping me or Andrew.
>

All good, thank you SJ!

~Gregory

