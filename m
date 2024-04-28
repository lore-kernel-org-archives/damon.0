Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C081E4B0
	for <damon@lists.linux.dev>; Sun, 28 Apr 2024 18:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714330000; cv=none; b=Okyfr9c1pEdHZFMHSQm0ocjrfi4FRsGBIBVFeCn/FvI6JAb2Phy3y7m4QFYsUksnC2ng1mLmVmkYYUhW67V/xiKM6ZToSTwDkjOf6Zflq+jF1G4Yi1EP0AX3F4eKMfY8+UycIR7ks9xYyDdBpOaiFJ4bjLdR+JsIYRxqQoutLZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714330000; c=relaxed/simple;
	bh=+TDXDGICXBDsD3uTxTGRcxLiFJBGpPczBWH1+Fw/6tE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=E9Axg5eM5KEVrSISEDy5OHKp48SgMuNBKaltI1+IMB1R7fKBTl0JeTtc416ym6UlROBqmmlET/I7AUYCAWpqw5dwU0dZ2WhXl+NGR14nSlFTBXFrtjt17yeUY5KGeQYXve91T+2eyBEJqYlR7tNGl0E4LAdCKq5Glr/IEfLhCBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrUVqbFa; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrUVqbFa"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51c077cfc09so4371215e87.2
        for <damon@lists.linux.dev>; Sun, 28 Apr 2024 11:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714329997; x=1714934797; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oovdv5aFvjC2suh0TZ6qgQUTs6Do6W9H86IhON70Uks=;
        b=GrUVqbFa2BZEabHJxY+Z2eTBdT1LvfQK1E5NEk6lDNyfs2nnMgJdqcQQuonqsxNBsr
         t2BOJyhxwd28BgiIdGJ56BU9ux2YkaS6q2IxmS0QPVRni79F7JRGYWu/dq34WC53DnnB
         D+LXnEO7TPwYOWZRang8Rlu6pZAO4u3h8dLr94iRd4UZtUdr9FZuCkO2+9eTcGMEs7u5
         lIMaggWetc544kuad+aYLrfZQkPj7YYmi2UhgG6wdcpld6nGdcZ/ed4thN+p7zTqcabL
         8zJ9Am5mJ6hpJajpAsNj7PqYlmc6dU8kZyRcjjkRKDf60VNNC7WUOU0+syZXGXCyIeHB
         UEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714329997; x=1714934797;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oovdv5aFvjC2suh0TZ6qgQUTs6Do6W9H86IhON70Uks=;
        b=Xy0TKosS5dziCnY79HXcj7YOMraFCYgJhwNmms75tUkbYvNJ/HLtE4tupgaQqj7JRV
         aMVlaPdVQEiXWz4sFqPxSYjRXScI10AIo9gcmodg9tQxuNxrXjJvvb6c0OEazZGDDvQY
         c0VdZ4nymRvA3fEnGf6MP2QK41+zeNRa81VO5irFPF4dxt88BEK83gMunEskeyN0f2Ap
         OP/bU9bJcB3Gx56ZWHbv2dqucZMqdvfuL0NCnCoKCC3Gkq9ChRXom82GXzCfp46ksTM+
         Ok8bmxmltq/PFaGrb3nKH0Lolde+hO7jF9OIdWGUXQoUUuk3R6bvM5L4KgrpKchDu7kl
         /WOA==
X-Gm-Message-State: AOJu0YxMBLo/NavVoDpMLZ4BpI7eXuMbq+cFh+DaPOlj0GiS5zj4cHEU
	5H8h83p49nMxHX6kTbSOVwECJTWURxOURTaDRatS5jPW2ew40tAb
X-Google-Smtp-Source: AGHT+IEP4ZbR8JyCq7DW0vKKDNEWZaYRcijWnxOpfNnNtACE7lC7QGMoqlElZ6eQI9EhLzfNNsuy1A==
X-Received: by 2002:a05:6512:368e:b0:519:5a3c:e468 with SMTP id d14-20020a056512368e00b005195a3ce468mr4742651lfs.12.1714329997072;
        Sun, 28 Apr 2024 11:46:37 -0700 (PDT)
Received: from [192.168.0.107] ([217.107.125.136])
        by smtp.gmail.com with ESMTPSA id c16-20020ac24150000000b0051d0beada77sm630642lfi.302.2024.04.28.11.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 11:46:36 -0700 (PDT)
Message-ID: <8f3b1832-60b4-4e13-aa61-32188eac4370@gmail.com>
Date: Sun, 28 Apr 2024 21:46:35 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: sj@kernel.org
Cc: damon@lists.linux.dev, yorha.op@gmail.com
References: <20240428165726.46959-1-sj@kernel.org>
Subject: Re: [PATCH] DAMON: Fix return value from damos_wmark_metric_value
Content-Language: en-US
From: Kirito Asuna <kasuna784@gmail.com>
In-Reply-To: <20240428165726.46959-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

SJ,

thank you for your comments, I tried to address them in the v2 patch 
(https://lore.kernel.org/damon/20240428184159.188535-1-yorha.op@gmail.com/)


BR,

Alex

