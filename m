Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CA213C3CD
	for <damon@lists.linux.dev>; Mon, 29 Sep 2025 03:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759116983; cv=none; b=T5UwOL1sSvbUGp3D2bBdZGWXZvGAgwPQMg8/hkOOPJ52aU1n7xnLLTHEJtx/zhidAZXCG+5jGVjYsZ8IXmBjJDQ3W2aAnOOUpqgYAerBu66qqvySoaJDiAHSan+efkNlD1qyyJ73ZmF4hdJQc16K1t74NsS6BLspOjPAcJKpCFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759116983; c=relaxed/simple;
	bh=Mk7qCHEHeRm5f34ad7g3oqwBc5ePNUYYkUb2mivPTnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qpLOMN9M3F432LGZTVekpWUzRgbYmXMtkuN1Zgy15PqpuRdbfAe56707c2TW06Jxds9QcU+HTqgMK25U286nbYfr9C3BaYRCEkTzpP3KZsDAneY94pZLEttQssqgcmQBMmDn1YyO5Gve4nDxfrBSri+PFUFf2WRWGJqaEQvj6O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8E6514BF;
	Sun, 28 Sep 2025 20:36:11 -0700 (PDT)
Received: from [10.164.18.53] (unknown [10.164.18.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06E033F5A1;
	Sun, 28 Sep 2025 20:36:09 -0700 (PDT)
Message-ID: <1d7fed49-f67b-4a70-bc67-7643e2db4e99@arm.com>
Date: Mon, 29 Sep 2025 09:06:06 +0530
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: Fix some typos in mm module
To: Jianyun Gao <jianyungao89@gmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, baohua@kernel.org,
 bhe@redhat.com, chengming.zhou@linux.dev, chrisl@kernel.org, cl@gentwo.org,
 damon@lists.linux.dev, david@redhat.com, dvyukov@google.com,
 elver@google.com, glider@google.com, harry.yoo@oracle.com, jannh@google.com,
 jgg@ziepe.ca, jhubbard@nvidia.com, kasan-dev@googlegroups.com,
 kasong@tencent.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, mhocko@suse.com, nphamcs@gmail.com,
 peterx@redhat.com, pfalcato@suse.de, rientjes@google.com,
 roman.gushchin@linux.dev, rppt@kernel.org, shikemeng@huaweicloud.com,
 sj@kernel.org, surenb@google.com, vbabka@suse.cz, xu.xin16@zte.com.cn
References: <3c3f9032-18ac-4229-b010-b8b95a11d2a4@arm.com>
 <20250929002608.1633825-1-jianyungao89@gmail.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250929002608.1633825-1-jianyungao89@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 29/09/25 5:56 am, Jianyun Gao wrote:
> From: "jianyun.gao" <jianyungao89@gmail.com>
>
> Below are some typos in the code comments:
>
>    intevals ==> intervals
>    addesses ==> addresses
>    unavaliable ==> unavailable
>    facor ==> factor
>    droping ==> dropping
>    exlusive ==> exclusive
>    decription ==> description
>    confict ==> conflict
>    desriptions ==> descriptions
>    otherwize ==> otherwise
>    vlaue ==> value
>    cheching ==> checking
>    exisitng ==> existing
>    modifed ==> modified
>    differenciate ==> differentiate
>    refernece ==> reference
>    permissons ==> permissions
>    indepdenent ==> independent
>    spliting ==> splitting
>
> Just fix it.
>
> Signed-off-by: jianyun.gao <jianyungao89@gmail.com>
> ---

A patch is never sent as a reply to a mail - please send it as a
separate email from next time.

Reviewed-by: Dev Jain <dev.jain@arm.com>

