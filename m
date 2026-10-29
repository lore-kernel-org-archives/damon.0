Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793242866;
	b=wSJO+cjhwCIckhez3qiyeXy7YOmbdHB8hlmg+US12WddhoM35sfFQPs0Wgu4RzJIGN6S
	 yI4KYmZjLnxDO9NRGAgVdbBoUb5dkHImByASYbQ0MUM61oiVyWUgomnF5zCRN0+UPC77F
	 ehbvHl8B/Rz7vynPPmHymnvzTtFQGni/gXW0k2Ts/wKNcXatTgYicMyNk33l/KonDKdUe
	 7Z6a8M3CRiM3j4PxATNyf+AKtYdS/IxsP+124B6LdTnrFq9PthnkNgXEgGcCxdHSBAsdK
	 1CAQd8NqqP63HASXqKQ/R5aN1S2EfS+76TXXK8ahFb1hStatqngM2o1P1+0nT1mY5tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793242866;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Bkm7zevt2pJ24dJThsCd2BuWJE9RCkG+R9d+KkvdTQI=;
	b=e3Phs2bO717BtFIekfsixd27BcHJSmcmVVoCxgj0KC01F7vBrQvyG/XwsaiKZRSXua75
	 BvTQBgmQNY40zT/gZC9bz1/BxbPx0wN0m6CrhuLRMw8I2IN6Jw9cCLdG1iyojbfx5YKJA
	 Zkq0m51xOH70EB7/b0T4nGKm9y6e08Q9io74wYplFmK4aC+SPvKTpI2LlCS6k3Z9TMDJY
	 VxUUCExeJhtnP3sJcbDTXoNdMzOg7IpOyMtc9vq3+jWVjjp9wjtlBUXCsWkisr2i0K3LR
	 8S18qxKau+5fQaCRxOQyO84Fnc9uXhZi6z77Vw+2lLNU8R9YKo1FQ4G93aWs3yv9dlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AiByQUxj;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9FE606A31D
	for <damon@lists.linux.dev>; Thu, 29 Oct 2026 03:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D9FE606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AiByQUxj
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e946155442so12936465ad.3
        for <damon@lists.linux.dev>; Wed, 28 Oct 2026 20:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793242865; x=1793847665; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Bkm7zevt2pJ24dJThsCd2BuWJE9RCkG+R9d+KkvdTQI=;
        b=AiByQUxjj5TxmHqMsPRfUmaLyscEwEjcJ+agrWiyh8+OD0/NjTf3p4InuZkhTFg/W8
         woOG+pYrGOH3n6J4d82dtt+wi5eQIqE0hT8+VD9i9/EY983nDJi8g+oucl4Ep3UFrA01
         esrd4CShV9E9892f22v1ooZ2NVVvW2mK6TeAG0I/VvZ01H0v4Cid1+CeT083dUsfPgR4
         QmAaWy26yBwQQU5xVwa3AxC4h6qn0dkASOPhLJPLpVIKBFrcop0M+OfpwoF1Dn4BF91Q
         5gJl/dYkX3aOb2c4Nnk9OtTJWZ7pGhyLRKFmzsL7585cNfWS35DBe1BZfBqxp/UGMyVt
         QQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793242865; x=1793847665;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bkm7zevt2pJ24dJThsCd2BuWJE9RCkG+R9d+KkvdTQI=;
        b=ed5/78Rwaq9DODTVoBcfpWkU5vbv1KH6xYIuT/+9CiXITgPmp9mOUV5ZwcdAkf7lYE
         TllyAO2aVofQMtzeq0rCL2sStPYU/ge07yBp+26A/HgQffdtyLvbk8y+eStN9TagbTZ9
         Mh8nQi4AYiLJanNwdu8UK7NuSpMMQqC6PWL8W8NnkLkomJeKYvWQnAMGv4jxlRhqT7k9
         TuDq+cvZ9PIq5MyanSyiNBZSyT+wE2CJf+WQMRe31TOef2LKs54LqinH6afeSkSqwHT1
         UricyS3SKRBZ3ChdGeh/q+aILk105M10EfFIrFEOVC7o7ukSuhYJRNgIxZYWPOgvwskR
         midA==
X-Gm-Message-State: AFq9FYID93nXpbK+wqmlUdgWJkd59Ml74b3N7g6i9P8gNv9e3uZdnrm8
	dZP803jFq8syUVRyj/JGG1mm66g6+25r/0gcR/wUoWQJNFSp5iq+qRXe
X-Gm-Gg: AYBFou29l4nLrvRIq6kja7fSlv2M3sv6j7MSk5z7HK/LuDaaXpXn8+kPRBX8nf995++
	uIk7CscPgxjeN2R1PZ2F84kX5elTLIR/63E9dPD7dph3vgks5+OGbajp7jSowePsFSlfKsP7fOq
	DWJEsKU8b6xBkG/ezka30UG5vhjl0oxqvWoMb4Sy4F+0XQDOwLfy6ZtCGbVSvvct/sGLt8x8khn
	4z8wC62kNmyu9wtKXDNUOT3lD8QifHTC5rr04PfuoMUUlHfexviezdU1sApxVXzGueP8w/7gw4Y
	0gm6Vib9JTTq4u1bKNNqA7ewp+vUh1k9YIBNACi1Pr4EJAQtwVc0XyXjjgmzo7QrwPNIleCkJ1I
	FWQ0U9xUc60YYcDmuI7LUe49U7TZ+P2OMeY8LFb6Tiso64S0Q/QuLLCfMPQXQtxxSS9uPRwsdW1
	dDe9fWQgxelkx2EWM8rLFTtFd/bBrRcm9zh0eRcGQSZ+ZMVHdamg+JNw0Bb4pkX62xY3W4ERJZ4
	ch4XjPnq2qc/GYAsVXthJheMf3oU1rO6rubu3ZgZIyuZNWgAAX5kaU0eCqa7zT6dyrb7s5FBr2X
	r0U43latj0DcXotzLhFfSZ5MSRV9woRGzPl1jqP8HOKZ6/pbBnO9R065/MnL3IdsLvE0DGfYUAh
	ruBl+yV549mAI0RG688Lc03R1TH3Rbw==
X-Received: by 2002:a17:903:2cf:b0:2e8:1f8a:9113 with SMTP id d9443c01a7336-2eb00541fa3mr35157725ad.40.1793242865314;
        Wed, 28 Oct 2026 20:01:05 -0700 (PDT)
Received: from [192.168.52.49] (ec2-35-77-214-194.ap-northeast-1.compute.amazonaws.com. [35.77.214.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6b7a216sm26722755ad.16.2026.10.28.20.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 20:01:04 -0700 (PDT)
Message-ID: <8f353f85-b8b7-4808-9a18-86a8cfff307f@gmail.com>
Date: Thu, 29 Oct 2026 11:00:58 +0800
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/damon/tests/sysfs-kunit: fix leaked pid reference in
 add_targets test
To: sashiko-reviews@lists.linux.dev, sj@kernel.org,
 akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org,
 error27@gmail.com, wangkefeng.wang@huawei.com
Cc: damon@lists.linux.dev, linux-mm@kvack.org,
 "Liam R. Howlett" <liam@infradead.org>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@kernel.org>
References: <20261029015725.17378-1-xiaoleiwangxiaolei@gmail.com>
 <sashiko-outbox-188628@kernel.org>
From: Wang Xiaolei <xiaoleiwangxiaolei@gmail.com>
In-Reply-To: <sashiko-outbox-188628@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/10/29 10:02, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] mm/damon: memory leak of ctx in damon_sysfs_test_add_targets() on skip
> --
>
> commit 15e9d751202cdf7c593524fe7b4266b6f6dd0dbf
> Author: Wang Xiaolei <xiaoleiwangxiaolei@gmail.com>
>
> mm/damon/tests/sysfs-kunit: fix leaked pid reference in add_targets test
>
> This commit fixes a struct pid reference leak in
> damon_sysfs_test_add_targets() by calling damon_select_ops() to select
> DAMON_OPS_VADDR on the monitoring context before adding targets, ensuring
> that damon_destroy_ctx() invokes damon_va_cleanup_target() to release the
> pid references. If DAMON_OPS_VADDR is not registered, the test cleans up
> its allocations and skips itself.
>
>> diff --git a/mm/damon/tests/sysfs-kunit.h b/mm/damon/tests/sysfs-kunit.h
>> index 138a4b8d14e73..634387c6178b9 100644
>> --- a/mm/damon/tests/sysfs-kunit.h
>> +++ b/mm/damon/tests/sysfs-kunit.h
>> @@ -79,6 +79,14 @@ static void damon_sysfs_test_add_targets(struct kunit *test)
>>   		kunit_skip(test, "ctx alloc fail");
>>   	}
>>   
>> +	if (damon_select_ops(ctx, DAMON_OPS_VADDR)) {
>> +		kfree(sysfs_targets->targets_arr);
>> +		kfree(sysfs_targets);
>> +		kfree(sysfs_target->regions);
>> +		kfree(sysfs_target);
>> +		kunit_skip(test, "vaddr ops not registered");
>> +	}
> [Severity: Medium]
> Does this error path leak ctx when damon_select_ops() fails (for example,
> when CONFIG_DAMON_VADDR is disabled)?
>
> Earlier in damon_sysfs_test_add_targets(), ctx is allocated via
> damon_new_ctx():
>
> 	ctx = damon_new_ctx();
> 	if (!ctx) {
> 		kfree(sysfs_targets->targets_arr);
> 		kfree(sysfs_targets);
> 		kfree(sysfs_target->regions);
> 		kfree(sysfs_target);
> 		kunit_skip(test, "ctx alloc fail");
> 	}
>
> When damon_select_ops(ctx, DAMON_OPS_VADDR) returns a non-zero error,
> kunit_skip() aborts the test immediately without calling
> damon_destroy_ctx(ctx). Should damon_destroy_ctx(ctx) be called before
> kunit_skip() here as well?

Agree, fixed in v2

thanks

xiaolei

>
