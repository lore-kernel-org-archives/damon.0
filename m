Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8E6322A2A
	for <damon@lists.linux.dev>; Wed, 14 Jan 2026 02:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768359483; cv=none; b=hN8jqQpukYjCq7smK57C/zYkcRsN+ldSCmGcimhsFIS2Eb/azAgfbKnY+kWBCVUW/G0Bgohs6CetHAzURJRPh2qYMXhvW74gR2cQgYdNHIQPl+EpXWK9HJk6C/X3axFaQ1reBPEvvKCQEEdEam3uIwGfpy4cznEyBII3CuU7FIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768359483; c=relaxed/simple;
	bh=qb8rwnsuMbygV2NKFyD/w8kWzaNcBgvAZYAG3Un3Hx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2imairagvt4jK1Od5Mc+9MeJPo83pX4L8F+0+ZPaaxwcCRsnBThCbCQL4wu5RHyXtyDxXTXCdFuvjbTvSw0mRY96RLKBgGHmJ+IhruNydR35sac2YiIA1cGCW97dCXyxuHVXsq/Wo5Nrtkg08Gg5JCJwfC3YykkZPuWjNmXwOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFeg+1au; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFeg+1au"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-121b14d0089so9288902c88.0
        for <damon@lists.linux.dev>; Tue, 13 Jan 2026 18:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768359481; x=1768964281; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qb8rwnsuMbygV2NKFyD/w8kWzaNcBgvAZYAG3Un3Hx8=;
        b=DFeg+1au3AN0WnCFh7VSoCO+csUfG7ZMs6gh+w08EPaKsyK+8l4B5HytKTEVnHAST7
         YJHYOkTyJ0ZZMJDG9iK9TFvIloR51Sw6NzDIj0oSmaPoCBESlez58bWs3mtEgEhgxrw0
         QeeWNCx9qACDeKcB0zy9VuMdQT6DXviM+6nZJ0KyVvmVZ1cXQj5TCCEt1OuLKTm1gDC0
         uIwIx/Bzujcp6K+pGVQbJjdKaAst/XdMdiDmVkafLazFfFuGlvY+Od+wA4v5gB2ZW2fW
         mnZ92/FhL4eC0HBPDGUkp9ceAwF1XyeDhbBqmXK+UKnl2IEnQnUHsO0qkZkpp2+O/uhj
         h+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768359481; x=1768964281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qb8rwnsuMbygV2NKFyD/w8kWzaNcBgvAZYAG3Un3Hx8=;
        b=OhIiPdSPE95TkL2CTJDd1enDoCSpp4CWxLwRq/IIkOvWMRWGm7P8HsTuZOIiL+GgxK
         BEsyp3qXI5HmrT2xsw1wAewkIUYuDqUryqruH/nptFbrnFpxc3d1iQY2nmmzYTTFhOzl
         lKVH6ULWVP38G40h63m9Owc+ZXVv50H5c1vrS990K3TWgusPs3hdnQMHExixzQai+sBg
         ufJ2F3CGocLn63MpjJHilvUye0eZcbFpLeege0qTULXOcBEtde1IKNsEjpGP+A1gCcxT
         jGZ6mAX42yAZYFvWfNRb+DMZMNp3NzKmI8i9O75qlvVZN7Hjm3hZa1hL9H8Q7otaT8/m
         tjwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvhW2/UKIRt3urLH9159xR0WA6blpPX9yjSDwGkqgUD/cdVGfkaUsgM8SVKNiqwkMVDNO3rg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwcOoSyczCWwMQvYDBPc5mzLN4ARF/Au/qfwH2J/7JU536Dx7A1
	vfC3yY4Hm68DiT7x+VFjreqPKFsBmY46djc8H0mcySJgd9KGIwFShGfW
X-Gm-Gg: AY/fxX4eSWB5p05k7NQztun6+7LPMdRIgpUUu2wGOa+RA/CXZqb54FFZTN/FM+Vz/BM
	VBo9OfYn/UnJz/0mB2VdujvncQ/7+hbdbXrS0b3QaY6FfHnCESREtfziEnqYhfxjlNVQLGky7Vm
	a8K6lLAPCV+ao+Y0c/G0/aEptNGAUotWgdcRS4BreyXKVLSuj1ekid4Upe37+YdK+2w6oe0pFbF
	fHSYNTkZ/lJ8ryHjRa/OdW3rQu85g7CE6vjwmS+nXWAzmFnHg/2b0+wqdfsO4qz8SPvchaGdugY
	Gz0v8MSwOenfLQGBn28YtnE7zefYeK32mFISU6R0XsSOE4IXrRspUsK6nxUD6mUg7ab9dVaWEw1
	sxGT5iKGzbHf/05DERyk5ZuKLb5TcTu4yKLR+Q6lexHLc8zH6pwUQan9UZasCUMxj/jzRoklZkG
	nq
X-Received: by 2002:a05:7022:e803:b0:11b:b3a1:713c with SMTP id a92af1059eb24-12336a0c131mr1161500c88.9.1768359481063;
        Tue, 13 Jan 2026 18:58:01 -0800 (PST)
Received: from localhost.localdomain ([2607:f130:0:11a::31])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f243421esm29604541c88.2.2026.01.13.18.57.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Jan 2026 18:58:00 -0800 (PST)
From: wang lian <lianux.mm@gmail.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wang lian <lianux.mm@gmail.com>
Subject: Re: [PATCH 02/11] mm/damon/sysfs-schemes: support DAMOS_QUOTA_[IN]ACTIVE_MEM_BP
Date: Wed, 14 Jan 2026 10:57:52 +0800
Message-ID: <20260114025752.82096-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260113152717.70459-3-sj@kernel.org>
References: <20260113152717.70459-3-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


> Add support of DAMOS_QUOTA_[IN]ACTIVE_MEM_BP on DAMON sysfs interface.
> Users can use [in]active_mem_bp keyword input to the target_metric sysfs
> file to use the new DAMOS quota auto-tune target metrics.

> Signed-off-by: SeongJae Park <sj@kernel.org>

Hi SeongJae,

The sysfs interface updates look correct.

Acked-by: wang lian <lianux.mm@gmail.com>

--
Best Regards,
wang lian
