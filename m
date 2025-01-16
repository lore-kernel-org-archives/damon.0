Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E15022ACEB
	for <damon@lists.linux.dev>; Thu, 16 Jan 2025 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737040525; cv=none; b=XwcdrtXIAAkPTkEhuV/HB2//QM+IhHsqLKy2GjSPebbJ8rKM64JCTu3XoJ1Z78Eb0WnsSUE/trFUFPlUzL9r/ai7U4w+epGeNj/adlkTdvtjsYK8AwFJrI2R2Y0YwuReH9ASPvGx/VzqAvR69Ki/UGQXQZXXj3zyskaoAMgZWfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737040525; c=relaxed/simple;
	bh=nB1obEkMkhnYZLUO3v9dMta8N2KputMNiFicxFu6b4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lheUjOlrVyBuN4ekzIDuWCR4lM/jNvQIpqhxuZTj7mpWxqrIT9ntGs7hon/j/CFyw4o2osHKJNHocGMwc3PHL0895rf/5S118da+L4eZ/ZrLHPgXaG9L6lUBfhzSrbjC6FVmXOpGE1Mi+86an3X9huYVyP2jUCXX4uIXVzWspxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9GYKwmC; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9GYKwmC"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d96944401dso1932761a12.0
        for <damon@lists.linux.dev>; Thu, 16 Jan 2025 07:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737040522; x=1737645322; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6RH+r5gJ9pE8Sk8uR5i7VFZeBIrqaHXmPgWC/mbNp38=;
        b=C9GYKwmCy1D3sOyMsVfK/J2V9ZHthxVTk0BtBsbNtnwH/dLgwc33ZW/07aU4vbVNyd
         a32j64+JNUSWIyQfVWj/NlX9mSFK4/mSvwUslI1N7pYL+t3QFqx7xEuySyO/p7XV0Uo3
         Hi/yDUVjZvVPEMzb6lg8XtD9HB0DjkFgPXgWVUxx0Bob3SA5LTI5UgY9SwcQfEbzH5Ej
         buChCp2E5uRRPAFuFXf1AnUSJuVTekSeF5Yy+98HyGUTDhNFSolmN7R5fRTmBv8ulip2
         wDqJJevt2JmLjKggMPir2rZTS3XQeZq0SJDXFID3VhMMDQ5bhA6H+/CYeRzKNl8WV33k
         yB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737040522; x=1737645322;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6RH+r5gJ9pE8Sk8uR5i7VFZeBIrqaHXmPgWC/mbNp38=;
        b=lXyZqOtDTpWuZdGtWp34Ivz78ePKBoxRsPw8VDz1jMkjxvA4rbRQroloY8PKAleHLx
         iH8vcY3QTNCMf7Hi0h2aKu1PAvejTibW6b74trqEgkbrY7y7QhiOoAXU3tW0+QQJkhBI
         jgX54Aj8a/dQIklhIcpiO4NNXrHy/oauinoTxFG9XWKk+joAYSMa+2vKQufQOmBkTG4J
         uOfAJ++gu4VvwRy8U+hrrXgZZxgFpQjgpdOm591B04VRjo7hfTszNXoo9Qr35D5qcJGe
         hbEkcUJ+bvwuUgevttrNmdt4REQ67I4JCF8/r0DF+HeeP1Fe1Y7N7orpHpBOmDhcE3yO
         e0ew==
X-Gm-Message-State: AOJu0YyOM/lcoaJaTDwleylejERsAk2CABc9kcSrXyBF+htq9jcJcn8B
	iol0dB4dhwijtbrgUezDR1ijAz9cWWw137rLRypalwCq7SMNFyAr
X-Gm-Gg: ASbGncvnEK4ul0lT88huzxZJ47DotK5iMoOVPZXdJ/B8anzEBYvvyHsdm6TGe5JeMpZ
	w988anOj6ze3eespaq39n+irQpS8JYcBh++5eC7E1rTU6Cb4TU89+fDaiTfl7A8iua5T9i+yoE1
	/to4JcNyTrg/dKkHJIsB6b3tqqD4m+1XfzIhYsjEtCYvRBTbciepFLEzguo8sIQlLYTxpg8pPf6
	47aWfXu1zdk3N7bJ95Gvr/3Yn9+32tXNobamn0DhqezkPntYTyc1U6JIOQgv0e54zX+eWIOMjSs
	gnaS9zG7xwhSEHY6LJfI1fjc3FPT
X-Google-Smtp-Source: AGHT+IGnNvDQCBZmPilSvTbvkkxRT49OaJ4mSKAULMRBfoxW9sU+N3eCbFXDy5atLKEbxXiVCIqYJQ==
X-Received: by 2002:a05:6402:210a:b0:5d9:a54:f8b4 with SMTP id 4fb4d7f45d1cf-5d972e06cbcmr30643161a12.11.1737040522200;
        Thu, 16 Jan 2025 07:15:22 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:829:739b:3caa:6500? ([2620:10d:c092:500::5:fdd6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73eb56fbsm53177a12.64.2025.01.16.07.15.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 07:15:21 -0800 (PST)
Message-ID: <bae5af92-c050-47f3-919f-ed3bf1c485be@gmail.com>
Date: Thu, 16 Jan 2025 15:15:21 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v1 2/2] mm/damon: introduce DAMOS filter type hugepage
To: sj@kernel.org, akpm@linux-foundation.org
Cc: damon@lists.linux.dev, linux-mm@kvack.org
References: <20250116144436.3947318-1-usamaarif642@gmail.com>
 <20250116144436.3947318-2-usamaarif642@gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250116144436.3947318-2-usamaarif642@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16/01/2025 14:44, Usama Arif wrote:
> This is to gather statistics to check if hotest memory regions
> are backed by hugepages. This includes both THPs and hugetlbfs.
> This filter can help to observe and prove the effectivenes of
> different schemes for shrinking/collapsing hugepages.
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>  include/linux/damon.h    | 2 ++
>  mm/damon/paddr.c         | 3 +++
>  mm/damon/sysfs-schemes.c | 1 +
>  3 files changed, 6 insertions(+)

The corresponding DAMO PR is at https://github.com/damonitor/damo/pull/19


