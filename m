Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6116941C72
	for <damon@lists.linux.dev>; Fri, 27 Mar 2026 08:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774600040; cv=none; b=FJVt4+KJi3tsni6zERfkBqJrC0fWeeBw4dk6f/ODm42fjlUT8EPHlfJAMw8kj6oDTpy7TYLVu7en7TrmYgruCOoDxJ05oUPXvO+Hv/AooDQ8dCwsioCABZ8ZzASv+pacwWepgVLd8raqtM6OqPtbVVVDMsZHuQZfsZazr0ywi7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774600040; c=relaxed/simple;
	bh=Ix1x2Gc9TOTa09u6PZYJkcuvighJEyUpu7gjDbkQXRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8RnJulXaOwLeoC6QB4G/bWe4HPOnRIzs5EAhPXtoz9+u7TILUtBc8MnU/iQR8UpKwb7AvJmmw++aYrVOndgNPe5uQ4/qHHWQHXX/G21VsbNtk4CYnzPGsArcTnCbjFCUvASIH/GFdIfpUu+SibYgZBcapzpSdmDNipUiSK5qdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgXPbXUv; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgXPbXUv"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2aaf59c4f7cso8074215ad.1
        for <damon@lists.linux.dev>; Fri, 27 Mar 2026 01:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774600039; x=1775204839; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zFEQbGpayE+Pr5tEfSyFKldUTAWitnPQ4DLSjCOmEc=;
        b=hgXPbXUvQtHUw2kcPEiFysLbMcxtAU+MHhWW/zqxrBkPOKejq30yo7WvnMxTuQikih
         SOopDjCFso3wGETSIk2ohQb59SfCfnXcVsRZ/gVPfwAh3OaRH5JZBO8a+/W6MWCkkym3
         oZNy6tbT0oatcabTGfszegy9IUzOGVEQN1buN1oSEe8rBb2ZH3aPzCbI/LKASf5E0/14
         f9h+qaD8nfdWehTMl42+8VgQomRyRY5+sDojie8kA7JKaeWif9zUtcmSxWhIASf/mvN7
         OgFOp4H7Y//Olghl5sFawJ27eLOkjqRCzY9Xh8Y7FlkYpVM6YaoFz6Jtv1DY7azK3aDN
         uFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774600039; x=1775204839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5zFEQbGpayE+Pr5tEfSyFKldUTAWitnPQ4DLSjCOmEc=;
        b=szQ3fbu9mht0uWYIaXz9P+fVlrJ2ezDwwBcfTNXguYZpGaKyZc1DS5UDwfaJAh1kxq
         FViV1h5NF4GY5uuOxnk4fmspB8mHEa6Cs6kkpB/MIbutgcw7kuKEUDa3e8p65pvjEu+W
         VS4QxGu5N5ak+44KljdpIZgsfjXDsPB8R9Jz0k4c5JBZebpfyZP+djiUI0Kskmlydhr8
         Tn8tKBAocoevsCdOEqYM63smX1eYu640Z2d2+bdRdNc0dfRHkYKVxCasMX8lIjI5aSxy
         +zf4jYDiquzlprM4LvyVz1x3cXOANy3IE8Q7o7SQ48Oj8qM1awLzbqEps0qy9HiK45/u
         nJJA==
X-Gm-Message-State: AOJu0YweaAfwkyc1EbXeJv2rfIz/gU/CUXCpANo//JNWp3d9XRQhjrZn
	c7u+rV6HRzKnmn/13zv4/6mjtq9VNkHM6wJStx7/hop7WcOwuf+KrGXXYe64Rw==
X-Gm-Gg: ATEYQzxDHJEF0Y79LLWbZdLclxfk61t3u/qANfq42Sy89W/5kkJ2Inj9/ym+9TxcD1/
	GPSipB+ZGPDNx4X+TRRbX1T/kanVYGU837wDCsN9ZGsndZiWlq3j3V4m6MLf0BMKQUg/IvS/Sfb
	MDBnZDCGhcjiAt2O6t/FxC2Z5959IMBmr321iZW6uJ9SIrfSRp+PDCwKPEr3Yxgm9nf8g5/oFCf
	OfEsOg0CtGEGpEVOHTEqg/i5PX7CTnCyEu13l6uz9jyCji8ropc+FArvXR/xArWaOt/YliYf+6J
	RRIBJ5H6e7TqFGhKaQjGUTk2g4MADeMk/lQ9FgtejCwsem/+PTkr3TJekb9fUtEiksJ/J2NYz5W
	bh8IXNTz8W3YkGRBReVk2WxsMBt5uIa8uYCj78ieES1ZvqLvbXM9q+UHsIgXZ0JDrpT6Y2PuwO5
	Or4oHGDdxt3JXMP2vCIGpSpLYObLPOKnkCSpivuA==
X-Received: by 2002:a17:903:46cd:b0:2ae:8253:1452 with SMTP id d9443c01a7336-2b0cdc1f89bmr19842335ad.11.1774600038586;
        Fri, 27 Mar 2026 01:27:18 -0700 (PDT)
Received: from celestia ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8a89basm53150415ad.56.2026.03.27.01.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 01:27:17 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: aethernet65535@gmail.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	sj@kernel.org
Subject: Re: (sashiko review) [PATCH] mm/damon: validate addr_unit to be power of 2
Date: Fri, 27 Mar 2026 16:27:14 +0800
Message-ID: <20260327082714.83540-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327081131.80608-1-aethernet65535@gmail.com>
References: <20260327081131.80608-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [...]
> > @@ -1330,6 +1330,8 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
> >  	dst->maybe_corrupted = true;
> >  	if (!is_power_of_2(src->min_region_sz))
> >  		return -EINVAL;
> > +	if (!src->addr_unit || !is_power_of_2(src->addr_unit))
> 
> This isn't a bug, but is the !src->addr_unit check needed here?
> 
> Looking at is_power_of_2(), it already evaluates to false for an input
> of zero, so the compound condition could perhaps be simplified to just
> !is_power_of_2(src->addr_unit).

You are right. Futhermore, addr_unit_store() also prevents 'addr_unit'
from being 0.

Best regards,
Rui Yan
