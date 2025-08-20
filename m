Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AD12D3A6A
	for <damon@lists.linux.dev>; Wed, 20 Aug 2025 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755685203; cv=none; b=cYy/E91aDpVT7IJLgvJgGEDpeILxmbxJfYHgc+ux1L6AhQOg4qqNJHeCgk22h2sPzTQsxI2JRVReQKqJOwGwQv6nnDeYXxRlLiuQabS7TBZV8kLj7nknknk152XPLv6Ay0jnSy1qMDXTAe1xi+QHuQPr9xQ2392csRe7LT/Vv1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755685203; c=relaxed/simple;
	bh=ixt4MI8sNyddrirHCmjXmC66O0F6v4cBEiLL8VcL9OQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bRdXd/Ks3MJnexknePbPGwn7cvs3jS0uAXwqDbHSsiRYMU57zLtXijYkDZMC6UszJTEgTJhWU4W/yC9YSgQi6D6VL3CCzJtWm3rQwNEZqNuRYUiVJ9zYQOSa5MSxoo5z9cI0N8Ywu5Ct9JEJZtb86LGN9RUPDGJYowkfbE9a1iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4c6Mqk1B1zztT9v;
	Wed, 20 Aug 2025 18:18:58 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 1B2AD180485;
	Wed, 20 Aug 2025 18:19:57 +0800 (CST)
Received: from [10.174.176.250] (10.174.176.250) by
 dggpemf200018.china.huawei.com (7.185.36.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 20 Aug 2025 18:19:56 +0800
Message-ID: <3a894ee7-0d07-496a-bbb8-abcc431b849b@huawei.com>
Date: Wed, 20 Aug 2025 18:19:55 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH -next 00/16] mm/damon: support ARM32 with LPAE
To: SeongJae Park <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
References: <20250814160429.67476-1-sj@kernel.org>
From: Quanmin Yan <yanquanmin1@huawei.com>
In-Reply-To: <20250814160429.67476-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf200018.china.huawei.com (7.185.36.31)

Hi SJ,

在 2025/8/15 0:04, SeongJae Park 写道:
> On Thu, 14 Aug 2025 22:07:12 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
>
>> Hi SJ,
>>
>> Thank you for your detailed suggestions on the patch series. Please allow me
>> some time to thoroughly review each of your recommendations.
> No worry, please take your time :)
>
>> I haven’t responded
>> to every point immediately because I’d like to first attempt updating the patches
>> accordingly. If I encounter any questions or issues during the process, I’ll promptly
>> reach out to discuss them with you, very appreciate your patience and guidance.
> Sounds good.
>
>> By the way, this patch series is based on linux-next(commit:2674d1eadaa2).
> Thank you for sharing this.  From the next time, please use mm-new[1] as a
> baseline for DAMON patches if there is no reason to not do so.
>
> [1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees

I've prepared the v2 patch set based on the mm-new branch[1]. Your valuable
feedback would be greatly appreciated!

[1] https://lore.kernel.org/all/20250820080623.3799131-1-yanquanmin1@huawei.com/

Thanks,
Quanmin Yan

