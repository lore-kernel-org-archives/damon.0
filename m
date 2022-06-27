Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D904A04
	for <damon@lists.linux.dev>; Mon, 27 Jun 2022 17:00:20 +0000 (UTC)
Received: by mail-io1-f41.google.com with SMTP id y18so10213101iof.2
        for <damon@lists.linux.dev>; Mon, 27 Jun 2022 10:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1n5+tTXfxvB7wLEdpHqCm9+HbbRZEAGOiM6JchYLEEA=;
        b=TuIDyDjh+Fh8IvzIgcxLkECsvGgepX8QCxNW5muxgMj4AuxdvJykORfH+B33q2pSUz
         aCPMMkkphNHOGRuWbIWhyQThYGYG0oAT8QKG8Ii+lgnwRaCSFyvSV15xWdJalgo72ieJ
         BaaPgTXTMUgSePlhvCeaA9m9fgtz63Wslx2qY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1n5+tTXfxvB7wLEdpHqCm9+HbbRZEAGOiM6JchYLEEA=;
        b=OA5GXuOlyvlgbpf0MWGr1zSVwxd6YzWA6Dm7s5n0uwJVZc8OMtBJ32WIdcjIuY+bxh
         Aqr4s89uk+C/G7kic6XGMOy3wY2u+SX++WAJRRVr6jCCNM5OY+oPxy3YZBHAhnukZdK7
         S+pVZP6taUkePUnQf/A0cj2xA00k7AEsRGpbwwP3aqVGmIBejAMHN3BVRG4Zl7DO5/2Z
         YCzURRLRBqQV3XQLVwgztITB30Q3VTDvGCaPzAAdmrf0gpc3ZZdqCoakSZcBDv3NkdL5
         iktTQP9FSVesyTFRUYqF9WVmwNr0yIlxsBDeY/WRbcE+I8qMNISGI44v2gTdurEdW3R9
         efKw==
X-Gm-Message-State: AJIora8xC95o4ooeYEi/bVBTtOMqwagFfPm1VMhGc7AxnjwseGjbC2e0
	zhuthTk/2eob7+qP9M4qkRfcsg==
X-Google-Smtp-Source: AGRyM1vka6RjReMyIAyXcFVuxqCEEEXnk7tcE9JyWX3Aza/OqWoGpuS3GK/cWr9ft69qR0A9bFPljQ==
X-Received: by 2002:a02:c48e:0:b0:33c:25bb:a1b2 with SMTP id t14-20020a02c48e000000b0033c25bba1b2mr6820280jam.180.1656349219772;
        Mon, 27 Jun 2022 10:00:19 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id f11-20020a02a80b000000b0033c14d2386bsm3090948jaj.75.2022.06.27.10.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 10:00:19 -0700 (PDT)
Subject: Re: [PATCH v4] kselftests/damon: add support for cases where debugfs
 cannot be read
To: SeongJae Park <sj@kernel.org>, Gautam <gautammenghani201@gmail.com>
Cc: shuah@kernel.org, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20220625200334.83818-1-sj@kernel.org>
From: Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7d6b7de6-4609-e6ca-0a88-1f9799c70769@linuxfoundation.org>
Date: Mon, 27 Jun 2022 11:00:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20220625200334.83818-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 6/25/22 2:03 PM, SeongJae Park wrote:
> Hi Gautam,
> 
> On Sun, 26 Jun 2022 01:22:45 +0530 Gautam <gautammenghani201@gmail.com> wrote:
> 
>> The kernel is in lockdown mode when secureboot is enabled and hence
>> debugfs cannot be used. Add support for this and other general cases
>> where debugfs cannot be read and communicate the same to the user before
>> running tests.
>>
>> Signed-off-by: Gautam <gautammenghani201@gmail.com>
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>
> 
> 
> Thanks,
> SJ
> 
>> ---
>> Changes in v2:
>> 1. Modify the error message to account for general cases.
>> 2. Change the return code so that the test is skipped.
>>
>> Changes in v3:
>> 1. Change the name of variable holding the error message.
>>
>> Changes in v4:
>> 1. Correct the mode of the source file.
>>
>>   tools/testing/selftests/damon/_chk_dependency.sh | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/tools/testing/selftests/damon/_chk_dependency.sh b/tools/testing/selftests/damon/_chk_dependency.sh
>> index 0189db81550b..0328ac0b5a5e 100644
>> --- a/tools/testing/selftests/damon/_chk_dependency.sh
>> +++ b/tools/testing/selftests/damon/_chk_dependency.sh
>> @@ -26,3 +26,13 @@ do
>>   		exit 1
>>   	fi
>>   done
>> +
>> +permission_error="Operation not permitted"
>> +for f in attrs target_ids monitor_on
>> +do
>> +	status=$( cat "$DBGFS/$f" 2>&1 )
>> +	if [ "${status#*$permission_error}" != "$status" ]; then
>> +		echo "Permission for reading $DBGFS/$f denied; maybe secureboot enabled?"

btw - does this run as a regular user or does it need root privilege?
If so add a test for that and skip with a message.
>> +		exit $ksft_skip
>> +	fi
>> +done
>> -- 
>> 2.36.1
>
thanks,
-- Shuah
