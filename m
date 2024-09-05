Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9EA1A0AF3
	for <damon@lists.linux.dev>; Thu,  5 Sep 2024 21:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725572449; cv=none; b=ZMGPAK+0ky/4Lr7tK3ABHOKeYfV9qbe/9Hlf8qN0WSQQ2m7exyhWQ46ZuHQhX4uaqPI+gcHQXTsIF49B4WJes7k/frLKZY/gH1v6CLKMAhmPYhPMamGhtjX13R373KVzV7K85CqoP79NxGZn/V8WZgIrSjH01UHylHR2FLEaHE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725572449; c=relaxed/simple;
	bh=jtZum9aNuEaXj/isFvv5DW4LLbKg6FIXVvFN2Zh9CMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lg5C0FU1dwETnvIKKhgDQr/DHQgl61zhtqU71xuvU/AjuUWVSMOKB0JCE8cbSETwkFUzi313CZpVyuVONvhigNEh9ucmxOAOQjHvxLAnQwbAZLaebHstpGCbRZx17jwwFlb1TNAU/jMgRFRvebwx4YIEV3WrL32AqVsayAhRIP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ou6Nf21X; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ou6Nf21X"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-718a3b8a2dcso299653b3a.2
        for <damon@lists.linux.dev>; Thu, 05 Sep 2024 14:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725572447; x=1726177247; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=bbtyiYEcSAgf2UeSJrd7kG/9VEfvzqOigpjQ9MBNIFg=;
        b=Ou6Nf21X64MOiEex7QDjjdklFqY+v1j5v/jEhj3wa0T/vTkHPyrgCWy+wk7iiFqv5X
         TWFwuavplZ6B8xSHrt3ca85vhd4sG8ncO1+I+JNJl61WhgrK4YEdgtXzSAwVkcH7ktRa
         moYoa3WiU1XfagxYGhHdA490JfIZ8vm/btvTM1CU7M7v5GsNjYpjHq/Q7QdvUmkVTukq
         hb1P25mtSZEItPQFUcnVTOfKxUkcOvnr5yQ3lGHyLIhEXtGeO1wOp48taq09tfJ/kPFd
         n+1WY1/xxqp+k/PJeuooKAguHcH3rl7p2ZS+0jaFyVWpBJYvPBEN9FQ7YsGxxHGAjvoQ
         hDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725572447; x=1726177247;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbtyiYEcSAgf2UeSJrd7kG/9VEfvzqOigpjQ9MBNIFg=;
        b=e8IKQj/vawTTnI0KrDrMTS7nxl+PwMG2P+ovfJBeXZfSQ7pAw5lzp9fX/jQDnADXxM
         9cVv4jc5FKiwJCzmTc003Z4kWRiWTq//29Prdd932+bqsEYcpW5SKDP5KjbRbkKhX+bm
         HGCFRS/ZUAQUsBFaIJ+2N6viQ9E3/p5XKiQEvHBLr5+zhzHqC2CPzXBlWdqm82+tiesI
         Xb3z9i0uk+gC3N/WO5YcbyeWbHJQz2ZZWex2mf+NuP9oR/RMLnaKtV9Zesadi5SkbbLI
         Pxh3JalxH5mUG5NLB1kKCg8BAzlf9e00JqmA7pnGNNB1jY2F4mfHl3j9BH7BCb0cVEbT
         wuJA==
X-Gm-Message-State: AOJu0YyU8KbqE/9f2/JkJqOEBiMUanbjjNqavXaySIf8r5UbXPTKI9T2
	RrViqlIjbKbd+7v6nzeCUXhjh3rPehS1XoSW2QxZhC/nxJV/qPDJ
X-Google-Smtp-Source: AGHT+IGPu0hlK1VagwZi4ioeZ2DG9siu64z/3zMRPrUFDlWNp2kAJwHbc/L9AuB07MIczt0C4UqCvA==
X-Received: by 2002:a05:6a21:513:b0:1cc:e659:8008 with SMTP id adf61e73a8af0-1cf1d12f6b3mr355029637.26.1725572447055;
        Thu, 05 Sep 2024 14:40:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7178d8e0b01sm1647955b3a.6.2024.09.05.14.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 14:40:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <df091a2c-b9cc-46ce-9107-b3300cf06abc@roeck-us.net>
Date: Thu, 5 Sep 2024 14:40:45 -0700
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm/damon/core: avoid overflow in
 damon_feed_loop_next_input()
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240905172405.46995-1-sj@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240905172405.46995-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/24 10:24, SeongJae Park wrote:
> damon_feed_loop_next_input() is fragile to overflows.  Rewrite code to
> avoid overflows.  This is not yet well tested on 32bit archs.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/944f3d5b-9177-48e7-8ec9-7f1331a3fea3@roeck-us.net
> Fixes: 9294a037c015 ("mm/damon/core: implement goal-oriented feedback-driven quota auto-tuning")
> Signed-off-by: SeongJae Park <sj@kernel.org>

Passes all my testing except for

Failed unit tests:
	arm:mps2-an385:damon_test_ops_registration
	arm:mps2-an385:damon
	xtensa:de212:damon_test_ops_registration
	xtensa:de212:damon

which unrelated and not surprising since those are nommu systems.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter

> ---
> As mentioned on the commit message, this is not yet sufficiently tested
> on 32bit machines.  That's why this is RFC.
> 
>   mm/damon/core.c | 33 +++++++++++++++++++++++++++------
>   1 file changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 32677f13f437..1d951c2a1d85 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1494,15 +1494,36 @@ static unsigned long damon_feed_loop_next_input(unsigned long last_input,
>   		unsigned long score)
>   {
>   	const unsigned long goal = 10000;
> -	unsigned long score_goal_diff = max(goal, score) - min(goal, score);
> -	unsigned long score_goal_diff_bp = score_goal_diff * 10000 / goal;
> -	unsigned long compensation = last_input * score_goal_diff_bp / 10000;
>   	/* Set minimum input as 10000 to avoid compensation be zero */
>   	const unsigned long min_input = 10000;
> +	unsigned long score_goal_diff;
> +	unsigned long compensation;
> +
> +	if (score == goal)
> +		return last_input;
> +
> +	/* last_input, score <= ULONG_MAX */
> +	if (score < goal) {
> +		score_goal_diff = goal - score;
> +	} else {
> +		/* if score_goal_diff > goal, will return min_input anyway */
> +		score_goal_diff = min(score - goal, goal);
> +	}
> +
> +	if (last_input < ULONG_MAX / score_goal_diff)
> +		compensation = last_input * score_goal_diff / goal;
> +	else
> +		compensation = last_input / goal * score_goal_diff;
> +
> +	/* compensation <= last_input <= ULONG_MAX */
> +
> +	if (goal > score) {
> +		if (last_input < ULONG_MAX - compensation)
> +			return last_input + compensation;
> +		return ULONG_MAX;
> +	}
>   
> -	if (goal > score)
> -		return last_input + compensation;
> -	if (last_input > compensation + min_input)
> +	if (last_input - compensation > min_input)
>   		return last_input - compensation;
>   	return min_input;
>   }

