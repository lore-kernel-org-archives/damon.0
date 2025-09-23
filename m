Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE7C31D39A
	for <damon@lists.linux.dev>; Tue, 23 Sep 2025 08:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758616631; cv=none; b=QiIe/Wj9I+KwcEYA4Qgcm2hw136qGTxbg8Oglxp67+BJJ56Mj5HLHrtD8XseUzEudkA7EAA9s36TrQFF+pVC7uPvZ+c0an1MotxU7JvqC9npSTb4H/jKqYl7iVl7z+X6vWhUXb8vpnK5dc/a3FGZSbBstplIiG7QdBbFr/23/54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758616631; c=relaxed/simple;
	bh=aRloNIy049X0nvKk4THRNrmGATr+go0k7cbyNj2+wr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iry5TgNMJqQjkiWbwg3TxNJxfiNBeeyCMEGYo/MzXFJ3cekKdqqR/n1pC35CykybWzdSdIon0TpQCeJl+ZS2TlMAkZz0qneFo04mtGsT/ZOhM0bwyBTRXl78Qk+6f6ioSJrWIX3CQxZT+FLoYcntf2HLN3E+uuABgt03BxXE1QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R0DbxG2S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0DbxG2S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758616628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0FichtJezjG8Fw3oNsREz7KtXAArVifFDdwv8D/TDyo=;
	b=R0DbxG2S1/TmUh2Zg6uGZ9y8eXX9JHNN/2bWJhuMsfBfptS4c4v9vbsLPB5hYAw2dJeJ+p
	uTQVXYthIDxQN/gGX9M7F84dSQJ0YAk65ZFF9zhhArnUClTO8rqCkEcDtMgB8MmsRFaePQ
	lGFVAEXnJSTxyPKdhtEBAx5BBLmQ0kQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-WUuPM6SHOly1ePSjiMHT3w-1; Tue, 23 Sep 2025 04:37:06 -0400
X-MC-Unique: WUuPM6SHOly1ePSjiMHT3w-1
X-Mimecast-MFC-AGG-ID: WUuPM6SHOly1ePSjiMHT3w_1758616625
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ccd58af2bbso2551148f8f.0
        for <damon@lists.linux.dev>; Tue, 23 Sep 2025 01:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758616625; x=1759221425;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0FichtJezjG8Fw3oNsREz7KtXAArVifFDdwv8D/TDyo=;
        b=pBk9lCz2pxGS+bzd/02Btykuomtb1aKbuRsqMhw3Wnizf6npWwzEwVa/Re7hRycRCT
         y4yKPRay8zZr7qaPSQCfZ8wTq0e3bimMAK/5PdBSo6AGHDG/eyLsooUYOZTKZlakoPzt
         QHGpUkYh5hs+KUYad6pyRy/E2A0aHQJcwQFxtm5NVtHAUYygAz1ak+XjZOodRRB0CQBh
         nsL0DjIkaCGPMztl18fdbOytV8YotTog0d2fMFBOrU9GK/jVh6vGV0xu1YijDB2tfOEc
         YjGy6tujlB77zu+/imNqO0z8pD7k4V/arG1V+wf9SZUhDMK0e7K8Nb8neiVVosisBzxH
         jaUA==
X-Forwarded-Encrypted: i=1; AJvYcCU2cDLThiwISC9YAWcF3LRpn1r1cYQqkYCkt2CLOGQrs+zMOJXy1Mo2mheuJKnMTKEwSkeFJA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yya6VJpWL0Bk1Y2gL48SBo1BVOt29b3U7LipvPXUL4gKeoWXXGl
	vkhnMN9SNmFbRqowYWEQIVUmNdulUPRhr23vUh1GaHmyUN0UJWBO5FJEUlfiwoeqFI1BSKgGMxe
	oxuctPPD5zTJWVGR5VIhfXNfoIGXnoEcZuywQJ+BIdHA0U2nHY1HCDiBS
X-Gm-Gg: ASbGnctXyPnPfWjDlS2+e0LN6MPYThRDBTaAOCydrozy10CovdhUUTZ0mgzLDRCC0zx
	YUczXM4aRoiMEFbb32ZSFdzNcXuB2Dkba0ojJK6eX7NFAY/+ZNDk3SFT2bBluym0iReX/GBswwc
	B3ZEJxu1VS3Y87VjpaFRret75Sl/G8274vNU2G09ibPN+svZ7MQPs1DR/qicER+7V9hMetgc7nX
	4AbFhi7arB2e0Ws2xxSKTET+s0kr4LIM45zZImPE9dp28+ciGg59FVlr3xZyJr2G2ICf+aROOos
	XKq4d8xNOoJ8E2N1jkn4rz/UOKRDD3rOvW8x1ioSiJVvyJ2AhcGOsOomEsl4O9DXpYq2pTMb9e6
	rX4ju5Lz0HvKu0Irrg77l5kqiR3kPu4U6Uvj30pfA0Pi6YmTvE+sNggwq9Tuuz6YfWQ==
X-Received: by 2002:a05:6000:184b:b0:401:c55d:2d20 with SMTP id ffacd0b85a97d-405d26c213dmr1225226f8f.26.1758616624906;
        Tue, 23 Sep 2025 01:37:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEawPPWnpwt5rFwfd2DqihY1bzY492tZVIfX1f84FZQOvJccOmfH7DP+skjktE9t2ycA3257g==
X-Received: by 2002:a05:6000:184b:b0:401:c55d:2d20 with SMTP id ffacd0b85a97d-405d26c213dmr1225200f8f.26.1758616624459;
        Tue, 23 Sep 2025 01:37:04 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4f:700:c9db:579f:8b2b:717c? (p200300d82f4f0700c9db579f8b2b717c.dip0.t-ipconnect.de. [2003:d8:2f4f:700:c9db:579f:8b2b:717c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f829e01a15sm11575843f8f.57.2025.09.23.01.37.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 01:37:03 -0700 (PDT)
Message-ID: <bfede7e3-5295-4453-928f-8e7c0bf8f2cd@redhat.com>
Date: Tue, 23 Sep 2025 10:37:01 +0200
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v6 02/15] mm/huge_memory: add device-private THP support to PMD
 operations
To: Balbir Singh <balbirs@nvidia.com>, Zi Yan <ziy@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, damon@lists.linux.dev,
 dri-devel@lists.freedesktop.org, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Oscar Salvador <osalvador@suse.de>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ralph Campbell <rcampbell@nvidia.com>,
 =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>,
 Francois Dugast <francois.dugast@intel.com>
References: <20250916122128.2098535-1-balbirs@nvidia.com>
 <20250916122128.2098535-3-balbirs@nvidia.com>
 <2A0E854D-0B0B-48A8-A87F-E9D38C6823EF@nvidia.com>
 <5b9da42e-49a2-4229-81ce-625ce00ed7b2@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <5b9da42e-49a2-4229-81ce-625ce00ed7b2@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pYOURIQmubhw38thJ64cRA8_yXp74DYLwoSGQcAjDt4_1758616625
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>>
>> non_present seems too vague. Maybe just open code it.
> 
> This was David's suggestion from the previous posting, there is is_swap_pfn_entry()
> but it's much larger than we would like for our use case.

Right. If we can find a better name, great, but open coding this turned 
out nasty.

-- 
Cheers

David / dhildenb

