Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF0C3F9CC
	for <damon@lists.linux.dev>; Mon, 16 Sep 2024 06:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726469230; cv=none; b=SZX99evfJsYOkXekVaOKWw7VZt6zD8AYnsdwoKPBH7V+FfVrZK3tEYH/BnqcPJPSWo8aQ25i9CkZP5/1QBc3PCR6kkf4r+EP4j8jqr1/5ASCYVe9Xxy14SAmzgKRl+WnWuj5yOPfSyHToJu9vmZ3vNGDhbKAI6ZJtN6ETuGWXQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726469230; c=relaxed/simple;
	bh=OG80MgUAOJqinc6SLwoLsrWGi0TgbXin9kAPTazF1Yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2yGBKL83tJjgmE/uk7Kj5yOW6yGqWCNOEWA9VF9dOlD1PzBJC1rwRxN2BBCeKEwfWj0ZoaRC8BfJ4vEqgwSvr7/LzevJ2uHOpby6lZbgfgxKkZEVCn4sF9tEz+VjU2NZHXsaGu6VYDDcBj6s2biPa6AyuI02DLjp09YZLC/NdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xb4A8AaG; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xb4A8AaG"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8a7dddd2aaso61772566b.3
        for <damon@lists.linux.dev>; Sun, 15 Sep 2024 23:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726469227; x=1727074027; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gPdxaFerpi8bwNdZqSdcGom7xPXL0OluVDs81MP+KUw=;
        b=Xb4A8AaG/XAaA0ZPwNPcYQP/5h58JNxWXnC+1sXy2+xX+VUhbXfb3okDpAu9OT6bBl
         fP4qgBu8SZOqApSgzaOowK77Y5wgLMrvYhq2KVrD02nNALxJu5wSMbbWFE/GOJnw47J3
         wxJx3vwePCIPns2DE+xcJYIA3YWNIlIMlVcvf7r7vmEi1rcATe1GUv29Ws31SOg1KV/B
         LselHkmuWI+ZMXnr6AgvywfHYwHHt0eKwzGsaV7iU7evUEfhbzFO0HSqrNcU2/sJQ6kp
         i9tfoImQZ+sC7vEP1mEmi4HgTzUVzzt+FhIqX/eA43qZ25w5SxrYH5zLQKQgNpQX1YcV
         7YYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726469227; x=1727074027;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gPdxaFerpi8bwNdZqSdcGom7xPXL0OluVDs81MP+KUw=;
        b=vxXExFASuf44d4kw9yjtg6CQZraHLjJfSSEqf8Bc5kdB4zyem9ZQNb7ABWchzwZR+l
         h3VBvfM3g7hDe3rvdIm2zLXa8g1BDcQNDqnXWqYAmFi8kg671R6wsFLz0tpJGPGI4gH1
         I03pi/05t3wfLfbymOwz7ZoC7dj86Cmx6e7M+d8r/NMuD38qiccrFq484erw/Hzl+hpM
         MP31ohPiGrCOstXqCwoGAFCoLznsJymlsGcqfPw6VUQHZ3OU+EAQGDDVxKzHG6/NIPYA
         kxC80ag42wiIGE5WOu09MXC+5GYAhieG7+9h/Ergj23priqOa4qvCbpDw/cGvuqsle9x
         Jm+A==
X-Forwarded-Encrypted: i=1; AJvYcCVkf0CVHBdRpFN5CYRM39Zy2Jimx7cTZdAhZl7NYbgzfOB2S9lcjI3SWprJ3oHJQv/NTXZFDg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJEVBRjquxx2WAPbuGJNYJb6zBFQH3iTOjDi/tyGsvMXPOQiAv
	4TNN9vHxqaMWvfUnyZCudmQZDUQXDtm6dHh0VK16ru4MkpjlutJ3
X-Google-Smtp-Source: AGHT+IEwDhcfs+zzxfqE7NF3pDPcvvh0KZPW/lPpb4hhRm4vVX1oAq0nk+Pi5hmaZt1Qh32LMsWmSA==
X-Received: by 2002:a17:907:7f2a:b0:a8d:2623:dd17 with SMTP id a640c23a62f3a-a902963723dmr598254566b.12.1726469226387;
        Sun, 15 Sep 2024 23:47:06 -0700 (PDT)
Received: from [172.20.5.37] (ip212232028077.rev.nessus.at. [212.232.28.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a906109688bsm270102266b.28.2024.09.15.23.47.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2024 23:47:06 -0700 (PDT)
Message-ID: <da7345af-1a7f-4480-aa59-153549714229@gmail.com>
Date: Mon, 16 Sep 2024 08:47:05 +0200
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: debian/config: add DAMON support for debian kernel
To: SeongJae Park <sj@kernel.org>
Cc: michel@michel-slm.name, damon@lists.linux.dev
References: <20240824233224.66696-1-sj@kernel.org>
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <20240824233224.66696-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This is really exciting news! With DAMON being enabled in the Debian kernel.

Link: https://salsa.debian.org/kernel-team/linux/-/merge_requests/1172

On 8/25/24 1:32 오전, SeongJae Park wrote:
> Hi Yunseong,
> 
> On Sun, 25 Aug 2024 02:26:11 +0900 Yunseong Kim <yskelg@gmail.com> wrote:
> 
>> Hi SeongJae,
>>
>> I have submitted a patch to the Debian Linux kernel team as follows:
>> Link: https://salsa.debian.org/kernel-team/linux/-/merge_requests/1172/diffs?commit_id=1c5f4aefc7791367bbf43adcd81594d1cb42aa66
> 
> Thank you very much for doing this great work and letting me know!
> 
>>
>> Please let me know if there are any additional details or improvements needed for my patch.
> 
> All looks good to me.  Nonetheless, Salvatore's comments also makes sense to
> me.
> 
> 
> Thanks,
> SJ


Thanks to DAMON maintainers Dr. SeongJae and Debian Maintainer Michel,

and every contributors involved in DAMON and the DAMO user space tool, this achievement has been made possible.

I’m also very grateful for the reviews from the Debian Linux kernel team, Salvatore and Ben.


Best regards,
Yunseong Kim
