Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22712379C49
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 14:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788358045; cv=none; b=hcxwJhTOT5yjNZVTmmzsHgQ1c/n9MmxmXOEuknWSK+kutga1djsXFl7HBrGHPny/ld7z+G95eCeKY5fgMwZLaxtgcgteayyMpCp9Q5ALUCmjUb5VysQ+RpXQEztK1ZYJwksqGbDkURsJEWVumrVVs56BsuwwCXr3dy0YgWef3ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788358045; c=relaxed/simple;
	bh=5R+g6WWRD1369zOrd1lygc9HCLZxNdDMskBf5JTl1/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2eWvececWlZWq1bLCIbersmppSAuLE4s+0cmrroDu9X4dsEhajYFX08qsV+vzmJhMSs0VxVlfoI1grGe1BA+ihzVH79MEclRkcRHAcNrBVBMueWK+YPX59buGmaANhkO5sU2aaCFpKNE9FiwCG6dqRMhgeoG8Onmr9Tfo8KM90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6ZHmh+s; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6ZHmh+s"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d5cad1a6baso10701665ad.3
        for <damon@lists.linux.dev>; Wed, 02 Sep 2026 07:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788358043; x=1788962843; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cu79MV34wPsRG2WV//Qk9X9lwsBT7aOPE1XdtKONwGs=;
        b=O6ZHmh+s/wjNOFM/Ps4H8UjO+g0P2nNcIw64q2SMm4XxFrw8ax8/gg4R+3b/1pe513
         2MkC1DyNMz2w675bqI/Czw5ULCzGOb00TzJPIzm4gb6IhHmJLJVce1ukqY5axrppmXmF
         QBKwPo7Wpoji7x6IQFBuwif48I8tAWMDflP/XPGqrVoo0LHOyY5djyBShAwERGP2eNYj
         LZV5MiiR21bAcTeS8hcuQQ4o0kcY+ZaVc9RyO4YtSdCMpTyUQCwdsj+iAApSRlCyRd3s
         idCBL5ZDvswgKKmnkh0zXXwVokpXlaCpcAxntOsgvoxL9jTD1QrZm90OpPFEtmMPiD96
         Zaaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788358043; x=1788962843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cu79MV34wPsRG2WV//Qk9X9lwsBT7aOPE1XdtKONwGs=;
        b=NdgJNVYputPWTVzCtvhjSGVBZwusOHic5EVxrHyyWgycMuc79NplTi8FkCKPazkqIi
         q4UYWSbi27dpZf0CstPQUfg6DlK/7RyyJjd4XTujChopyRY7WmuIQrHRpbl3iNe6yrkE
         P2SZSImXSF8AchjgPxeE4SJPrK+8YY4uMQuoCBajmQdggvO65e+OW+F5mj8pB1N5NH8N
         qnWkFhfgSA72itoqKB9AgOQWV98cSffcq+YlxGujV8dNGNKFWJkXviVCAguZVwPPn+pl
         lUEZkdjKIT+YQLsvKLdvX+oUFNHRcObsZHtXSCLgdopOW5eWaPbWDEkhEmXui6uRRUmz
         dvdw==
X-Forwarded-Encrypted: i=1; AKwUvBxJYntFF9pqHQSHzuMFk12ZN5pe8d3VphJgu8uliJBc0fmtgs/4q69S9dTJ/MDLbm4nXKt9rg==@lists.linux.dev
X-Gm-Message-State: AFuF++nMhD4VbwrYI/EQ5LjWMYDnCWlpqPIh64QWgUHdbQYb7lz7lBg+
	0EWs6/DpH88uInE8haA/weO/y65PPfE/y03bvUbp7lxGub6K/R2cQfIk
X-Gm-Gg: AYBFou2SYoXpuAEBbuAOR3LCY8Frdvd8yBRwwgs3buvLHhV/9tu4lbfn2I9D7T3dTiO
	VVIy2sUNKd7aD5g4rCI0f8DH7tEN5ehwSIr/2W4LdLZSgJiWKp/0029R0V8f4BKFyE1Mcv/2qiY
	DuM5psO3zI/x+pJTYvUWIVia387Izmwu8m3j84NBuUec93ISjvSDtVmoHm8FCTplIcB2J0jJAU6
	9GWWR7zFap8bwiXw1XURC7mB+8CUgbKQZalqdragyMq3dTgEI085iXvO6GdsKolXF/CPVANgD1V
	TmQlsYkGR+1zLa48obis736rD/gU3G/vA6v9zjPrKPIiML1QG7+O5ePgZK5ySqTXSvE0YcL1m67
	mMAw9akP6c8IWPsqVDIMECtUPO9lcaBzNe9vzjj6VFLDjXdbJ+loG2ARPt5yHhHWMycamafI7D4
	I+GHZKhSLdYq3Wv0PR6LC8cm53Va8hbbYX0W7o33+sPkwrrCAEkMVwnexUN90=
X-Received: by 2002:a17:90b:35c8:b0:393:194d:5366 with SMTP id 98e67ed59e1d1-39aedf43130mr7799632a91.10.1788358042526;
        Wed, 02 Sep 2026 07:07:22 -0700 (PDT)
Received: from gmail.com ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae380d7a9sm5579972a91.12.2026.09.02.07.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 07:07:22 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
X-Google-Original-From: Kunwu Chan <kunwu.chan@linux.dev>
To: SJ Park <sj@kernel.org>
Cc: Kunwu Chan <kunwu.chan@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 05/12] mm/damon/sysfs: remove probes number validation
Date: Wed,  2 Sep 2026 22:07:13 +0800
Message-ID: <20260902140714.4023700-1-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902054747.99370-6-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  1 Sep 2026 22:47:38 -0700 SJ Park <sj@kernel.org> wrote:

> DAMON sysfs interface is disallowing >DAMON_MAX_PROBES nr_probes input,
> since DAMON_MAX_PROBES is the upper limit of probes per DAMON context.
> The core layer is validating the upper limit again, though.  It is
> preferred to let DAMON API callers such as sysfs interface to set
> parameters in flexible ways, and do parameters validation in the core
> layer.  Drop the duplicated validation in the sysfs interface.
> 
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  mm/damon/sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 7ec14f48d157a..b576e97cbfdb8 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -1479,7 +1479,7 @@ static ssize_t nr_probes_store(struct kobject *kobj,
>  
>  	if (err)
>  		return err;
> -	if (nr < 0 || nr > DAMON_MAX_PROBES)
> +	if (nr < 0)

Hi SJ,

Thanks for the cleanup.

I was wondering whether DAMON_MAX_PROBES is purely a core invariant
or also an interface constraint.

With this change, sysfs allows nr_probes larger than
DAMON_MAX_PROBES and damon_sysfs_probes_add_dirs() will start creating
probe objects before the configuration is later rejected by
damon_valid_probe_params().

Since nr_probes directly controls the number of sysfs objects created,
do we still want to keep an early check here?

I agree that the core validation is required for non-sysfs callers,
but I am not sure whether this particular limit should be duplicated
at the sysfs layer.

Thanks,
Kunwu


>  		return -EINVAL;
>  
>  	probes = container_of(kobj, struct damon_sysfs_probes, kobj);
> -- 
> 2.47.3
> 

Sent using hkml (https://github.com/sjp38/hackermail)
