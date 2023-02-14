Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153E4C5C2
	for <damon@lists.linux.dev>; Tue, 14 Feb 2023 17:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1676397176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3wcl/mIBo22eXMS7cK2NpuJ4cYApHgRaBD0p8jlitp0=;
	b=X2jnQOfoGZoQbbwhgQv8dS9EAl9tI5wOeXAwIgXoRS0AMGuobpd2J0JKSJAg+MM+BoIsUH
	HI8nF1E3SzTEBQKnAgxa5VrpBmAWL6JGJcv4508/dFkXft0zn4RFyIPhCrX+UuZCroTaAw
	nemlfaYDnSmRD8lkM3LjPVVz5aXNSJk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-327-vaGxVXNIMZCTLHY2pQHzOg-1; Tue, 14 Feb 2023 12:52:52 -0500
X-MC-Unique: vaGxVXNIMZCTLHY2pQHzOg-1
Received: by mail-wm1-f69.google.com with SMTP id t18-20020a05600c451200b003e1f2de4b2bso2040800wmo.6
        for <damon@lists.linux.dev>; Tue, 14 Feb 2023 09:52:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3wcl/mIBo22eXMS7cK2NpuJ4cYApHgRaBD0p8jlitp0=;
        b=3Z6gTg5gOfJTJQHNSEoGAtpkaNRoE+2kluk7ugXSCaXaTLD2pHa4xFK5XAkufosMtB
         5hXJKhlJ24PAkQmw3KKfW4tJQ52tzL22ZR0ZXl05AZzTCoKEAYt3MPISOMtF+q5eTmWs
         /L8VnX+UQFEtwaJcTNglEKBb2z06A6qns0MynZAhHJeIHhxPMSK70z+ata4qs/wtP8PO
         gzSxSd/aSRxskBHKB1tCxvpIrHaD3ygHRLiyroUTp/eTGezPhvdoRl3ATe6uIw67M6qz
         gb8HUH5+6mdu1Uv+uAUvl4A8vBYWW0/IBCPH9wIALAHxUmpPY98rwc/xLY1d5waNz55p
         70qw==
X-Gm-Message-State: AO0yUKX+2+LI8fyIOOPGuD6n/NOpHBTbU8Qu5al8PjF43J5c+N4fgs45
	+rOvqVXF9UFR4hBTiyukCIVmfrSKP29xIrN0HgSmU7L6qldtyMe6xruMr47DmLUwKD13qgfVZTo
	dItk+kMuc7MTptFg=
X-Received: by 2002:a05:600c:1810:b0:3df:e6bb:768 with SMTP id n16-20020a05600c181000b003dfe6bb0768mr2663853wmp.24.1676397171493;
        Tue, 14 Feb 2023 09:52:51 -0800 (PST)
X-Google-Smtp-Source: AK7set+ibnmq4kcT8UCovLoaG/wupL1YfMy0JvPMHkpSzCbHZJ4rAhXM0UWak5dYU0hGHDSdoPp/vg==
X-Received: by 2002:a05:600c:1810:b0:3df:e6bb:768 with SMTP id n16-20020a05600c181000b003dfe6bb0768mr2663847wmp.24.1676397171263;
        Tue, 14 Feb 2023 09:52:51 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:1700:969:8e2b:e8bb:46be? (p200300cbc709170009698e2be8bb46be.dip0.t-ipconnect.de. [2003:cb:c709:1700:969:8e2b:e8bb:46be])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c2cd300b003dfefe115b9sm19847507wmc.0.2023.02.14.09.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 09:52:50 -0800 (PST)
Message-ID: <5064ee08-792f-14f2-6f2d-26e81af8a239@redhat.com>
Date: Tue, 14 Feb 2023 18:52:49 +0100
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 0/4] Change the return value for page isolation
 functions
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org, sj@kernel.org, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
 muchun.song@linux.dev, naoya.horiguchi@nec.com, linmiaohe@huawei.com,
 osalvador@suse.de, mike.kravetz@oracle.com, willy@infradead.org,
 damon@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1676382188.git.baolin.wang@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <cover.1676382188.git.baolin.wang@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.02.23 14:59, Baolin Wang wrote:
> Now the page isolation functions did not return a boolean to indicate
> success or not, instead it will return a negative error when failed
> to isolate a page. So below code used in most places seem a boolean
> success/failure thing, which can confuse people whether the isolation
> is successful.
> 
> if (folio_isolate_lru(folio))
>          continue;
> 
> Moreover the page isolation functions only return 0 or -EBUSY, and
> most users did not care about the negative error except for few users,
> thus we can convert all page isolation functions to return a boolean
> value, which can remove the confusion to make code more clear.
> 
> No functional changes intended in this patch series.
> 
> Changes from v1:
>   - Convert all isolation functions to return bool.

Acked-by: David Hildenbrand <david@redhat.com>

Although it's controversial if

if (!ret)
	ret = -EBUSY;
else
	ret = 0;

is really appealing to the readers eye :)

ret = ret ? 0 : -EBUSY;

It's still confusing.

would be better as

ret = isolated ? 0 : -EBUSY;

IOW, not reusing the "int ret" variable.

-- 
Thanks,

David / dhildenb

