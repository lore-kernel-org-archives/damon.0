Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9A11FA6
	for <damon@lists.linux.dev>; Thu, 23 Jun 2022 18:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656010046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bLAm3pMxOh+9zY21Oi845s3fU5zLtsAou6fuo/Fr2Z4=;
	b=duFKbtBCPiitPeBs2FIjpdzmeWSOO5PO7rX1Y7959lRRmlvSsqTM7XIsC3Gj/QBunBZ5GH
	O3WAhEcFVGdcQWBxcuVyMgd+iqAe9HhdNaekkO2Bh1kw/vI02md7YeQdMkMpMxCqzVzBlA
	EHfVpkqph664XqnZkCdJYcjYIKGG+J0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-mXTaVsE4MhSq5Nt-m2fCtg-1; Thu, 23 Jun 2022 14:47:25 -0400
X-MC-Unique: mXTaVsE4MhSq5Nt-m2fCtg-1
Received: by mail-wm1-f72.google.com with SMTP id i5-20020a1c3b05000000b003a02b027e53so1788427wma.7
        for <damon@lists.linux.dev>; Thu, 23 Jun 2022 11:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=bLAm3pMxOh+9zY21Oi845s3fU5zLtsAou6fuo/Fr2Z4=;
        b=S6fA9iGYJkV9INmi/OCOlXmMeN5QK6AEp5xEYAQvDVbApbSVVWw462FBLgl5YfmCGr
         +6t5/PGFVC3eki4Ft0ePRf7YWq3iqjL1t7nkNjq4yFnWSR8476J2YloWxSpXhp1c2re0
         Is5VgDzCB3nxVDxegB96gG8+Drio6FCepi11jON903n/sehM4uh+rtiUKQekgLQdktFJ
         3hGm9ApYzzjT57ApWnkSR9At2Wq8LHd90RMrpy++41rKZ3B9nZsL65ntH0mbin8Kv0iz
         C3o+610utAJXPSJzQR+2Uknha9vdRlfoGQq2hIAoGH9CW6Y8uXpAOY1gCHfl1tIbspi/
         SrYA==
X-Gm-Message-State: AJIora+I+Q43bylkVqFY4YU66WjPgENfusZuqmcdIutL3MB6OvmsLIPz
	HmbqpVWX1CKt5Rp+GqxwwHOXkFyc9K0QKWq/MuGpm+Qk/kWgKMKnOhOnyqGLXkUZTMSCL1eRACz
	Jpf8l1sHiiqtBjzo=
X-Received: by 2002:a7b:c242:0:b0:3a0:1acc:4893 with SMTP id b2-20020a7bc242000000b003a01acc4893mr5974861wmj.66.1656010044518;
        Thu, 23 Jun 2022 11:47:24 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t/VUf72rhZDrZZIGKZe7nO+zIr5UrHo8zc6e2z0WNLhkOCYb4WSIBQqaJSjp9/jUHkySkmQg==
X-Received: by 2002:a7b:c242:0:b0:3a0:1acc:4893 with SMTP id b2-20020a7bc242000000b003a01acc4893mr5974842wmj.66.1656010044308;
        Thu, 23 Jun 2022 11:47:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:b100:7694:f34e:d0dd:95e7? (p200300cbc704b1007694f34ed0dd95e7.dip0.t-ipconnect.de. [2003:cb:c704:b100:7694:f34e:d0dd:95e7])
        by smtp.gmail.com with ESMTPSA id q13-20020adfcd8d000000b00219b391c2d2sm195465wrj.36.2022.06.23.11.47.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 11:47:23 -0700 (PDT)
Message-ID: <b0699467-dc88-3b91-2f1c-4a1b54ac9383@redhat.com>
Date: Thu, 23 Jun 2022 20:47:23 +0200
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v10 15/69] damon: convert __damon_va_three_regions to use
 the VMA iterator
To: Liam Howlett <liam.howlett@oracle.com>,
 "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "damon @ lists . linux . dev" <damon@lists.linux.dev>,
 SeongJae Park <sj@kernel.org>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
 <20220621204632.3370049-16-Liam.Howlett@oracle.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220621204632.3370049-16-Liam.Howlett@oracle.com>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21.06.22 22:46, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> This rather specialised walk can use the VMA iterator.  If this proves to
> be too slow, we can write a custom routine to find the two largest gaps,
> but it will be somewhat complicated, so let's see if we need it first.
> 
> Update the kunit test case to use the maple tree.  This also fixes an
> issue with the kunit testcase not adding the last VMA to the list.
> 
> Link: https://lkml.kernel.org/r/20220504011215.661968-1-Liam.Howlett@oracle.com
> Fixes: 17ccae8bb5c9 (mm/damon: add kunit tests)
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: SeongJae Park <sj@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Will Deacon <will@kernel.org>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---

Nothing jumped at me

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

