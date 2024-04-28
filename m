Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C98E64CC0
	for <damon@lists.linux.dev>; Sun, 28 Apr 2024 19:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714331852; cv=none; b=SQZ3AZNMHdZsb+/2sUwIleNWhD2P6nHXyqNeDB0oMZHbexuM855nQrhvWsNLLjMTTqfmzy88ox9L16EPyq750eltlnlEfe4TplnVQ6o0J8XigumzKRW3mXgeGEOYt1iscO94k8buF9PYO9mbmIGd8HIpTNisxyyB7Kd2wpBag64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714331852; c=relaxed/simple;
	bh=lnOXVZc4SN8hZ25Q3uTkxcl9crdMCNInAom7xdTYSfo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=pUhjFKGhEcgpCWt0NRF1K4xlRx50cP7r92+HtfpZlcWHUKUcCej0wMJORbYAeYv9GlAN5SDa371E9yiSoNwb1hQgWCa9aunKAEjAy9+12KeUJ+RMdg7tkzIvCnDpVkjC0bqmImPqJDHExTYifziQK/vpuqCOdKOkc/BRsw/bESY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+7LNtxL; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+7LNtxL"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51ae2e37a87so4501539e87.2
        for <damon@lists.linux.dev>; Sun, 28 Apr 2024 12:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714331849; x=1714936649; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axXwQBPRjFckR4pqw1sKtoIBZ2p0ua0aTBVHinNmV+8=;
        b=J+7LNtxLoPJDbeJpNCSzyXf0C7uGqMZwu8iu8MJ9nf6FEoujH5vzS2zbXUBTIk6p92
         cvTOQHt9jUaPxppzEC2n7D8e5dk8juHI09KRED4duoz4sQpCAVqgibXnHOcbSEx6vMpP
         JI+YxSmK5fQ1KB6opGzX2gslZaEydqlqeL4pT5xfBkzLiiiM05pR6ijmiGXSnNFlF+Zv
         ndFailp90vqc2hDAsvAxnV8HQLABxDQCgWVdIfD12umR2S0XF3wb0FC7AIKmwvMLtXaQ
         5/KukU7AwZlsGsA0O831aj+uawbIbXNq7v7+0qtgzjDluRpPxISkxSom6lJhE3qxb8WK
         uO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714331849; x=1714936649;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=axXwQBPRjFckR4pqw1sKtoIBZ2p0ua0aTBVHinNmV+8=;
        b=oeScoLtN83INkFqFF9hePgIYBD1mmea9IFkAEoPTgGiMLUNcCKSjvJjTvD60okvE0C
         rhPZBCfjCDjC3K8djBM6rly8ieigfwGzlAYv7UKr5f2RDyb70oUKJ/L2NpXZIQttFbJG
         MTv1WApP2dP/FcojROYK2VF/j7O69gn4sm6FKiMpgnnugrhiMjemLUIrc6oCBj02aWlH
         mzr4cFlSDJHIoyzuV0vmhA+Npxy7uVcJ44UG6yTPGnDd9O8lPtkDfGj98qZEXLgX1md0
         WYqZac2aZlbTtTsVwMWLULPqht6ag5bETWCXZiR3raL4uB5RFbbiYERoiV1LA42S2tx7
         gPKg==
X-Gm-Message-State: AOJu0YxY4h/KeOU7ru6okrr1eDceUTXnVheJgJddULcS9vNWNnf9MvYZ
	xYLkJnYOou6Ck+TghTOCxLCJDpzxSpEtoix2Kj7QaPqHaGPmpm8z
X-Google-Smtp-Source: AGHT+IGpF/8p2BAxITgPUuG6mYU+9IDICMmUEBpKH9Hi3Neb1s3fjpOM2hwe5MRZGMG5GsS258j8cQ==
X-Received: by 2002:ac2:54ba:0:b0:51c:3f4c:ef68 with SMTP id w26-20020ac254ba000000b0051c3f4cef68mr4449973lfk.20.1714331849036;
        Sun, 28 Apr 2024 12:17:29 -0700 (PDT)
Received: from [192.168.0.107] ([217.107.125.136])
        by smtp.gmail.com with ESMTPSA id o30-20020ac25b9e000000b00513d1e9ce7esm3839371lfn.90.2024.04.28.12.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 12:17:28 -0700 (PDT)
Message-ID: <d14a5a00-782f-48c7-a3a8-2b62846d29a6@gmail.com>
Date: Sun, 28 Apr 2024 22:17:26 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: sj@kernel.org
Cc: damon@lists.linux.dev, yorha.op@gmail.com
References: <20240428185717.60110-1-sj@kernel.org>
Subject: Re: [PATCH v2] mm/damon/core: Fix return value from
 damos_wmark_metric_value
Content-Language: en-US
From: Alex Rusuf <yorha.op@gmail.com>
In-Reply-To: <20240428185717.60110-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

SJ,

thank you again for your comments, I'm not very familiar with sending 
patches here, so I'll try my best, thank you again!

BR,

Alex

