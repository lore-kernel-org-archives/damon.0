Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1D11EEA5F
	for <damon@lists.linux.dev>; Mon, 22 Dec 2025 11:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766403235; cv=none; b=N3ZTUkq7ua9DUk1RtC4WHdSjU0BM3GX/hjriSun1D7vwXWKWSVVmYvrGStCWlFyGgINOStM4lCVcXCFyk5+e1lqMYWsPYNKug4jjShAxj3AY9YQgk7BaChoqmaXa6r909vr5YHwTnP3isG1Jiizfs0+rSUbvWsRYx4OjH6Fk7aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766403235; c=relaxed/simple;
	bh=kay8zZXz8S+udyxAooE0AgOq5Zu9xza6Ab9pnSb/fqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQQQu+99HoLd0fv4yU2rBgjLnnraSRz4PbQGlzjep2Gzqss71G4yX8Xum/YVzMhgObzJTgjYpt34jWea6VEhDnYw4LxGtyfzT/CEH9tRmorTIwN1/KJ3MSTydqjsbKwL5HYjI86MVwZEPOraqSjjm0ZMTusXP3yrTeZbxYnvMm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUNtjLPc; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUNtjLPc"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-bc2abdcfc6fso2228388a12.2
        for <damon@lists.linux.dev>; Mon, 22 Dec 2025 03:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766403234; x=1767008034; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1AF1yX4GwtQvvuuOJCmg3PfUFD/RGUm+qcyOoMqIjVw=;
        b=mUNtjLPcC3/wHH1/i7sPPk4tzDMo1HmGYLNJvENwBkXBnBFJPXSWaU38U3cHnyHETc
         GLbA8YZb58Se2TTWzNEW92miyXg9JBQ81afeoM1ownECoQvux7wL7W/Gvbv+zZvKeDI0
         /0FILqXX8yW+G8p8uQQ9HLoG5lLe0q5t/nLd69KG7Z7bdAqaocKsgqKkfkZp3WQvmZFO
         iYpy7vyMk257AWCI1F/NkxLMop+e0UyS8nL7BhFAN9uZzjW76Iqs9rmyEuZ19VSOXZB9
         lxopLI8EG581GXUYiJXSf1yq6AbojUl4YsCBsoDZCfQQFUTfSC0Xf5ChYhpubFME4VHM
         Ta6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766403234; x=1767008034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1AF1yX4GwtQvvuuOJCmg3PfUFD/RGUm+qcyOoMqIjVw=;
        b=bj4FzxADPi8FL7NZm0WX8C51k+wC74wwh5/8oP2JfYdtl2sWmPdkf2CSQRJbYOyw6r
         2yl9Au40p50rQy4jdg5vA9AegQTGlKh4j+mKFTr41HbRcAweCXHk4W30l+4pwgkDQlsG
         fDTi0JwHl8mWXqZBkxVv6dWdPPPLZhkNTZ5g3Tk7AhwSvIRJGpGQPKGsBqtIbpIi0kTF
         TAEqgG9wJmKJyzTm9TveP7LRUDBRoLBuw5JmTEKndw8IKcpslRtHcIgaNZWHsc3RV6KN
         gx/spyRei0wypmxQ4c3joGaiIPKZQqUTCKbzpucwweLWoPtelHxmkZp3mnc+oalLKmIS
         fVqw==
X-Forwarded-Encrypted: i=1; AJvYcCUMs06ZGKPAlnOyBDcsX164s4pklBkS4XztHqwjcYOjLwNp/o3G0/QQ6qQeyCduxvoPsXIcMw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywd/r6F22GwVO/xF/Cifl6Px5GLPn7hLnXqpqh/aNtlZL8LQmxg
	g1LmJwy27OXSeXoQ/4nVHSwNj899vYyBALsQEzYzgO26z0cCxNy6T4e/
X-Gm-Gg: AY/fxX7F8Mg463rOF6FFOzW8NWl2Vojc/2Dr2cOxrkHCSXmMAs2dpdp9Yce0R+aY96Q
	mP4jDhSfBnC82lJnX5lhdUpaLo0BuCGISn6w+jt4hSqR6t20dHPzgAsk/o3lO3b0eKR5jCv7Do7
	l9CxaA3fjhSDcrdtDvh8lY9fapKWxZix6j/s1WfC0ndTViflGhAMWjHBvHaVTjNcwrRPwRBIWl8
	LEmKTegnqscCbzUszmBJDKfjAib5ZX6aDcy5Zwk8gUVCShAGMg86scydRpeTJheof+XYSCqYeTP
	umasnuVwRjTnALQyelYDKjjbVoJokm2eWE5u/+7DwxPRmjwYxA+kIiidnCpMeO2rZO1oiFp2kvr
	pde75iA6oZp7ObqtAxX2Gbzr9vEvRPsHMBEnQacp2qPTEIDSkI63yd91USL7f3yBVU2VfaOb0fF
	2BpQiCvsa5YjdZcA==
X-Google-Smtp-Source: AGHT+IF9z5OMf2RZbV65D44H9QFHtRDW2pkTFrUb5U1bgAOg1PPjFbvfwWh5UVEkpb/ShGV7F0BvFg==
X-Received: by 2002:a05:7301:508e:b0:2ae:51cb:7a98 with SMTP id 5a478bee46e88-2b05ec6d51dmr6586243eec.33.1766403233498;
        Mon, 22 Dec 2025 03:33:53 -0800 (PST)
Received: from [172.26.241.102] ([131.179.95.234])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05ffd5f86sm23562684eec.5.2025.12.22.03.33.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 03:33:53 -0800 (PST)
Message-ID: <a98e23a1-5be3-4c2a-a65a-c33853683674@gmail.com>
Date: Mon, 22 Dec 2025 03:33:52 -0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/damon/tests/core-kunit: extend test scenarios and
 remove redundancy
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, yanquanmin1@huawei.com, damon@lists.linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251221201356.43083-1-sj@kernel.org>
Content-Language: en-US
From: Shu Anzai <shu17az@gmail.com>
In-Reply-To: <20251221201356.43083-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello SJ,

Thank you for reviewing my patch! My responses are below.

On 2025/12/21 12:13, SeongJae Park wrote:
> Hello Shu,
>
>
> Thank you for sending this patch :)
>
> On Sun, 21 Dec 2025 13:01:14 +0000 Shu Anzai <shu17az@gmail.com> wrote:
>
>> Add some missing test scenarios to cover a wider range of cases. Also,
>> remove a redundant case in damos_test_commit_quota_goal().
> Seems this patch is making more than one change to multiple test cases at once.
> It makes following which change is for what purpose bit difficult for me.  I'd
> suggest splitting this into smaller ones that making changes for each test
> function, and adding more explanation of the changes.  E.g., a patch for
> damon_test_split_at(), another one for damon_test_merge_two(), and so on.  Not
> a strong request, though.
>
> I have two questions below, though.

I see. I will split this and send v2 later. Let me first explain the 
changes in detail.

>
>> Signed-off-by: Shu Anzai <shu17az@gmail.com>
>> ---
>>   mm/damon/tests/core-kunit.h | 51 ++++++++++++++++++++++++-------------
>>   1 file changed, 33 insertions(+), 18 deletions(-)
>>
>> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
>> index f59ae7ee19a0..e9ccc3fb34f9 100644
>> --- a/mm/damon/tests/core-kunit.h
>> +++ b/mm/damon/tests/core-kunit.h
>> @@ -158,6 +158,7 @@ static void damon_test_split_at(struct kunit *test)
>>   	r->nr_accesses_bp = 420000;
>>   	r->nr_accesses = 42;
>>   	r->last_nr_accesses = 15;
>> +	r->age = 10;
>>   	damon_add_region(r, t);
>>   	damon_split_region_at(t, r, 25);
>>   	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
>> @@ -170,6 +171,7 @@ static void damon_test_split_at(struct kunit *test)
>>   	KUNIT_EXPECT_EQ(test, r->nr_accesses_bp, r_new->nr_accesses_bp);
>>   	KUNIT_EXPECT_EQ(test, r->nr_accesses, r_new->nr_accesses);
>>   	KUNIT_EXPECT_EQ(test, r->last_nr_accesses, r_new->last_nr_accesses);
>> +	KUNIT_EXPECT_EQ(test, r->age, r_new->age);
>>   
>>   	damon_free_target(t);
>>   }
> I understand that the above change is increasing the coverage of this test to
> also verify the age of splitted region.  Nice.
>
> Correct me if I'm misunderstanding the intention of the above diff.

Yes, that is correct.

>
>> @@ -190,6 +192,7 @@ static void damon_test_merge_two(struct kunit *test)
>>   	}
>>   	r->nr_accesses = 10;
>>   	r->nr_accesses_bp = 100000;
>> +	r->age = 9;
>>   	damon_add_region(r, t);
>>   	r2 = damon_new_region(100, 300);
>>   	if (!r2) {
>> @@ -198,12 +201,15 @@ static void damon_test_merge_two(struct kunit *test)
>>   	}
>>   	r2->nr_accesses = 20;
>>   	r2->nr_accesses_bp = 200000;
>> +	r2->age = 21;
>>   	damon_add_region(r2, t);
>>   
>>   	damon_merge_two_regions(t, r, r2);
>>   	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
>>   	KUNIT_EXPECT_EQ(test, r->ar.end, 300ul);
>>   	KUNIT_EXPECT_EQ(test, r->nr_accesses, 16u);
>> +	KUNIT_EXPECT_EQ(test, r->nr_accesses_bp, 160000u);
>> +	KUNIT_EXPECT_EQ(test, r->age, 17u);
>>   
>>   	i = 0;
>>   	damon_for_each_region(r3, t) {
> I understand that the above change is increasing the coverage of this test to
> also verify the age handling of the merge logic.  Looks good!

Exactly.

>
>> @@ -232,12 +238,12 @@ static void damon_test_merge_regions_of(struct kunit *test)
>>   {
>>   	struct damon_target *t;
>>   	struct damon_region *r;
>> -	unsigned long sa[] = {0, 100, 114, 122, 130, 156, 170, 184};
>> -	unsigned long ea[] = {100, 112, 122, 130, 156, 170, 184, 230};
>> -	unsigned int nrs[] = {0, 0, 10, 10, 20, 30, 1, 2};
>> +	unsigned long sa[] = {0, 100, 114, 122, 130, 156, 170, 184, 235, 240};
>> +	unsigned long ea[] = {100, 112, 122, 130, 156, 170, 184, 230, 240, 10235};
>> +	unsigned int nrs[] = {0, 0, 10, 10, 20, 30, 1, 2, 5, 5};
>>   
>> -	unsigned long saddrs[] = {0, 114, 130, 156, 170};
>> -	unsigned long eaddrs[] = {112, 130, 156, 170, 230};
>> +	unsigned long saddrs[] = {0, 114, 130, 156, 170, 235, 240};
>> +	unsigned long eaddrs[] = {112, 130, 156, 170, 230, 240, 10235};
>>   	int i;
>>   
>>   	t = damon_new_target();
>> @@ -255,9 +261,9 @@ static void damon_test_merge_regions_of(struct kunit *test)
>>   	}
>>   
>>   	damon_merge_regions_of(t, 9, 9999);
>> -	/* 0-112, 114-130, 130-156, 156-170 */
>> -	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 5u);
>> -	for (i = 0; i < 5; i++) {
>> +	/* 0-112, 114-130, 130-156, 156-170, 170-230, 235-240, 240-10235 */
>> +	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 7u);
>> +	for (i = 0; i < 7; i++) {
>>   		r = __nth_region_of(t, i);
>>   		KUNIT_EXPECT_EQ(test, r->ar.start, saddrs[i]);
>>   		KUNIT_EXPECT_EQ(test, r->ar.end, eaddrs[i]);
> I understand the above change adds two regions on the test input, but I'm not
> following what logic it intends to additionally test.  Could you please
> clarify?

Both cases were intended to verify that damon_merge_two_regions() is 
called properly in damon_merge_regions_of().
The first one was intended to ensure that non-adjacent regions (170-230, 
235-240) are not merged even if their nr_accesses difference is within 
the threshold. However, on second thought, I realized this is redundant 
since it is natural for non-adjacent regions not to be merged.
The second one is to verify that two adjacent regions (235-240, 
240-10235) are not merged if the resulting region would exceed the size 
limit.

>
>> @@ -269,6 +275,9 @@ static void damon_test_split_regions_of(struct kunit *test)
>>   {
>>   	struct damon_target *t;
>>   	struct damon_region *r;
>> +	unsigned long sa[] = {0, 300, 500};
>> +	unsigned long ea[] = {220, 400, 700};
>> +	int i;
>>   
>>   	t = damon_new_target();
>>   	if (!t)
>> @@ -286,14 +295,19 @@ static void damon_test_split_regions_of(struct kunit *test)
>>   	t = damon_new_target();
>>   	if (!t)
>>   		kunit_skip(test, "second target alloc fail");
>> -	r = damon_new_region(0, 220);
>> -	if (!r) {
>> -		damon_free_target(t);
>> -		kunit_skip(test, "second region alloc fail");
>> +	for (i = 0; i < ARRAY_SIZE(sa); i++) {
>> +		r = damon_new_region(sa[i], ea[i]);
>> +		if (!r) {
>> +			damon_free_target(t);
>> +			kunit_skip(test, "region alloc fail");
>> +		}
>> +		damon_add_region(r, t);
>> +	}
>> +	damon_split_regions_of(t, 4, 5);
>> +	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 12u);
>> +	damon_for_each_region(r, t) {
>> +		KUNIT_EXPECT_GE(test, damon_sz_region(r) % 5ul, 0ul);
>>   	}
>> -	damon_add_region(r, t);
>> -	damon_split_regions_of(t, 4, 1);
>> -	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 4u);
>>   	damon_free_target(t);
>>   }
> I understand that the above change make the existing test scenario bit more
> complex, and cover the alignment.  Looks good.  But
> damon_test_split_regions_of() aims to cover multiple scenarios.  Your change is
> updating one existing test scenario, so I'm bit concerned at the fact that it
> is removing one test case.  I understand the updated test scenario is including
> the old one, but I think keeping the current test is also ok, as long as the
> maintenace burden is not that high.  So, instead of modifying an existing test
> scenario, how about adding the new test case?

I agree. I will restore the test case I removed and add the new one 
instead.

>
>>   
>> @@ -574,9 +588,10 @@ static void damos_test_commit_quota_goal(struct kunit *test)
>>   			});
>>   	damos_test_commit_quota_goal_for(test, &dst,
>>   			&(struct damos_quota_goal) {
>> -			.metric = DAMOS_QUOTA_USER_INPUT,
>> -			.target_value = 789,
>> -			.current_value = 12,
>> +			.metric = DAMOS_QUOTA_SOME_MEM_PSI_US,
>> +			.target_value = 234,
>> +			.current_value = 345,
>> +			.last_psi_total = 567,
>>   			});
>>   }
> Thank you for correcting this!
>
>
> Thanks,
> SJ
>
> [...]

Best,
Shu
