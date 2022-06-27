Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FE63D68
	for <damon@lists.linux.dev>; Mon, 27 Jun 2022 19:47:00 +0000 (UTC)
Received: by mail-ot1-f44.google.com with SMTP id l9-20020a056830268900b006054381dd35so8145573otu.4
        for <damon@lists.linux.dev>; Mon, 27 Jun 2022 12:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sEyIMurSbUDEtnO4sXJJJqiGT9VfNu9mH5Y+RF1zXpM=;
        b=Q/XU92EvXKhdUFHYTfxhesbhCz0S+IitCXqbWL1lwG8PNxG+l+4SrGA2WOvu8Hdddc
         hxNASREKZON99TgF7gAIPDYD0ndh2+wavjuNnWpuUEeMootx4hkqjxKrR9TgklvfT9DF
         NCYJjTEFsfdWM9OZUdQ8BfTDKs6pNJBV7n3tU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sEyIMurSbUDEtnO4sXJJJqiGT9VfNu9mH5Y+RF1zXpM=;
        b=4vykXD9xwsgV04/vTkUOo8M3127c+iSOYRd229GnP9O1mC2Bw8yMSzVj/a4Q8u2vX4
         PDokJkCXm28h+ZidMk05n3h/4DUR0DNFYaQKsDMxLJ3emIUx2HEGlAri0nd+qX3WhrsY
         a+/M8Kfh8f20VKcUYhO7yjZaVT2lxCkIii4yidIWNOG9/aORNRpysax9BUoMk87NgQSR
         Ofp04r4dENrL0y8b75YEuFP3obC8So2aCH8AsD98nWewM98fCpdWtfUzTE3RHskVoUPm
         Yt6JlNanY3+FW8OnXye3Ht/5XHtxNuAiPUt09Se0VPZmvxAeXAoPFSNvTSBRGOLvmdkp
         nEDw==
X-Gm-Message-State: AJIora9t04daUGjOZ2zQbYwuHmLTYuqiwoG0tHwlBAKYIrlj71yn0QGI
	kOKcFg/hD+ipB/bKIf7JDVLiUA==
X-Google-Smtp-Source: AGRyM1te5Bj88UBGJhxBv7OUhUu6rYyaYCShv/RM1GHQuJnIgZVd2AIbqFEHx30R36IqvOP82OnZBg==
X-Received: by 2002:a9d:76d0:0:b0:60b:53e5:6640 with SMTP id p16-20020a9d76d0000000b0060b53e56640mr6833397otl.241.1656359219758;
        Mon, 27 Jun 2022 12:46:59 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id h9-20020a056830400900b00616a19aac0bsm6693195ots.51.2022.06.27.12.46.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 12:46:59 -0700 (PDT)
Subject: Re: [PATCH v4] kselftests/damon: add support for cases where debugfs
 cannot be read
To: SeongJae Park <sj38.park@gmail.com>
Cc: SeongJae Park <sj@kernel.org>, Gautam <gautammenghani201@gmail.com>,
 shuah@kernel.org, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20220627185704.58902-1-sj38.park@gmail.com>
From: Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5708a2f6-4555-7bb3-4664-c33fe5b411b1@linuxfoundation.org>
Date: Mon, 27 Jun 2022 13:46:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20220627185704.58902-1-sj38.park@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 6/27/22 12:57 PM, SeongJae Park wrote:
> From: SeongJae Park <sj@kernel.org>
> 
> Hi Shuah,
> 
> On Mon, 27 Jun 2022 11:00:18 -0600 Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
> [...]
>>>> --- a/tools/testing/selftests/damon/_chk_dependency.sh
>>>> +++ b/tools/testing/selftests/damon/_chk_dependency.sh
>>>> @@ -26,3 +26,13 @@ do
>>>>    		exit 1
>>>>    	fi
>>>>    done
>>>> +
>>>> +permission_error="Operation not permitted"
>>>> +for f in attrs target_ids monitor_on
>>>> +do
>>>> +	status=$( cat "$DBGFS/$f" 2>&1 )
>>>> +	if [ "${status#*$permission_error}" != "$status" ]; then
>>>> +		echo "Permission for reading $DBGFS/$f denied; maybe secureboot enabled?"
>>
>> btw - does this run as a regular user or does it need root privilege?
>> If so add a test for that and skip with a message.
> 
> It needs the root permission, and does the check at the beginning[1].
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/damon/_chk_dependency.sh?h=v5.19-rc4#n9
> 
> 

Great. Thank you. I will pull this one in for linux-kselftest next
for Linux 5.20-rc1

thanks,
-- Shuah
