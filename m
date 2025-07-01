Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C5226F453
	for <damon@lists.linux.dev>; Tue,  1 Jul 2025 22:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751409844; cv=none; b=DqRVpddFfUrjBZ1zijhF+ywWyvoBkemifsRcGxU+VSDvRNqbES+3W8+KKWPrpXOGZMyOOY6eduBfcpKHa8ezz0vPeBEB0UMXOagpZakIlWgKbdfpHhBQaV6kwF8+jEMEEzqkD83hfCpIk0SRO8ZjJAoueorGGNfADOCcjjMaO0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751409844; c=relaxed/simple;
	bh=7sr/j6pKRahXta2Ds3J7bgr68QpT8C6nQo/PyJxSPSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tDwO1HzPbxbNGkLIjsaxcJsEEOlkkbseirwXOYnXEIqMPkwpfY3YSOUHM1lt3r+YKq1IWtdJqIx+1aOcubhPbAn7Tmhv5TJcoeBHYkqX08Wi+uuh75OKwc/yt+JY795RyXil0inTaBTPQFxlu0PTWyUtcs2JWY7zbLDxdfvIqK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fpe86/pV; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fpe86/pV"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e81f311a86fso4904515276.3
        for <damon@lists.linux.dev>; Tue, 01 Jul 2025 15:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751409842; x=1752014642; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4FeRd9wXeQwX3S1+5R3UHzHnQcV70Su/Q1eyBq9q7c=;
        b=Fpe86/pV86oiTivYLV7tov+vtHuVVk6YnogqXSO+ekdDXZRFbMVICuZfECHix888XV
         YLMBfEgcs0UmMjFFU9ekhiBQoiAGEGhL+puUkiD7Xrb63+cS7VTpcYv+OB2PtMaaFEUl
         cJf9NhlUHlk2usKXcfAaFbwhEUeXmlX8mKJW8nziWXIqi3lKg5FRpdGThq5zJyW0X52c
         +OMsCsfyy2klvxlhThqGMFudB6HS4oDktEv0ykbnIpsCX/NP5xMhsp48CA/x29kUsrbk
         rqvbSJZFFLMDAKHhXSGHQYZPXdgEaZsPX2+jnG9f6PZIV2akOwVCZLWVZNBRkMnZG3Ae
         9ltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751409842; x=1752014642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u4FeRd9wXeQwX3S1+5R3UHzHnQcV70Su/Q1eyBq9q7c=;
        b=Dc4XBjmKcfedWCL6UOHvYLoQXM2DaIO+OElrqZMFi5VmJQTUbiph+0Wtr4lH408Dcu
         8qWSj74WsREim6yKovEsE6zwGLMa2qR0ELT0z1UoA2imVzl321FWF6XAq4ZZ8Bl5mMN7
         KEa5o4K/HmvzW1sYg5nZr6MbyDngypy/BIOHy/eD/dlX8QnZWolve/tO7DXpEP2jTqzQ
         xiqCI2f+vApceUPiYmE5IR36Tgj6Seyg/PbSWbBr5XX6G78dbK4amqYYAZfwxTd3+Fdd
         j6qMUTpSVMVRY4vvWqdg1PMyGqI0wFlPIqQ6vdbfCWFSWE5+xTaOWFQEXBDBrPTGy0bm
         8yOw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ/QgCfOmvjcCS67YyL2fCnCDyjuFY9Mk1gn/Kmu2M9lD38bNrl02v+ICxT87Nj/0L6uA/OQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw0boujmp1hZB/qRWq7zdLdk+ZU2kZi5yScuAR3NwSboFmgG5sl
	+q6fWUZYe0i85hkT4JeJxYn8fOk4ocqUieeiB9mnabbZngZVsRzgP88E
X-Gm-Gg: ASbGncv2LAnisPp4fZ8iHi3QQCUqJRebefeHrCHBYqPUWU6GqLKK1gQ6xX9EO3ntepl
	iZR8iXULAsKI+92GovQhvUxKIPg+lQ+RWUDhiUpZGMVOuQ02cXoVSFLf4alwNHuQUuOOFR9CPYV
	g+GdBXtTig7k+jLUGq0jcvRn8trjVSibr3GiX5ZOrneSOWrUJgaiczBAv49HhvhUwWYC9WCVeDS
	0C/x0fsroWy7okX8kMSmcgjnad7tHDdCN08TtbGkpxn1zWETAITHlfzdg+oTVjD0Fsq+eTO9T9/
	3uYmJHy+BjDe9tYeNbe+abgPhk+89WzSfbFX5AcIIb/ddQ/tnp1lo0m1FK2NTiZR7x1VLeweY61
	0BduKiWazc2FBXNT/gg==
X-Google-Smtp-Source: AGHT+IHBPTQW25dLkI4nDbmWAJnJmoVAk9KwGoxI3zHd26yMzfgQe/ATjFFJf6m4R4d7cp8PptyOOQ==
X-Received: by 2002:a05:690c:6f83:b0:714:256:7917 with SMTP id 00721157ae682-7164d527940mr7001437b3.26.1751409841578;
        Tue, 01 Jul 2025 15:44:01 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:bdbc:6e11:c9be:13a3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71515c0464asm22189517b3.42.2025.07.01.15.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 15:44:01 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: Bijan Tabatabai <bijan311@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bijan Tabatabai <bijantabatab@micron.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/4] mm/damon: add struct damos_migrate_dest
Date: Tue,  1 Jul 2025 17:43:30 -0500
Message-ID: <20250701224353.9062-1-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621173131.23917-2-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 21 Jun 2025 10:31:28 -0700 SeongJae Park <sj@kernel.org> wrote:

> Introduce a new struct, namely damos_migrate_dest, for specifying
> multiple DAMOS' migration destination nodes and their weights.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  include/linux/damon.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index bb58e36f019e..d60addd0b7c8 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -447,6 +447,22 @@ struct damos_access_pattern {
>  	unsigned int max_age_region;
>  };
>  
> +/**
> + * struct damos_migrate_dest - Migration destination nodes and their weights.

Nit: Can this be renamed to damos_migrate_dests?
I think plural fits better because it stores a list of destinations.

Thanks,
Bijan

> + * @node_id_arr:	Array of migration destination node ids.
> + * @weight_arr:		Array of migration weights for @node_id_arr.
> + * @nr_dests:		Length of the @node_id_arr and @weight_arr arrays.
> + *
> + * @node_id_arr is an array of the ids of migration destination nodes.
> + * @weight_arr is an array of the weights for those.  The weights in
> + * @weight_arr are for nodes in @node_id_arr of same array index.
> + */
> +struct damos_migrate_dest {
> +	unsigned int *node_id_arr;
> +	unsigned int *weight_arr;
> +	size_t nr_dests;
> +};
> +
>  /**
>   * struct damos - Represents a Data Access Monitoring-based Operation Scheme.
>   * @pattern:		Access pattern of target regions.
> -- 
> 2.39.5
