Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847D31FC5
	for <damon@lists.linux.dev>; Thu, 25 Aug 2022 18:50:36 +0000 (UTC)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id CC6232E2;
	Thu, 25 Aug 2022 18:50:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CC6232E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1661453430; bh=y42Jf/ag9rU15ToKoopXiKAz4rUlonTv87e8xUVPCd0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RVEMFYtlAdcfdp9M02F2cjSEDTIPcvvWhZlWJbRfuME+Dmdal3T5IUCFQapXOB1VB
	 bWZBFis1jPQqM0li0LPjmGGpfVHpN4rXWMQl7fKBY6JCRz9qTHT+TqwwlDeZJ/N9Qa
	 J/XMyJz20DRhUzhFYbmC+uBBl/O5jDkW8jOwTGtirHakP5MZroVIAd45KsI+/6I8tk
	 b/GHl9/XTl7xMTkFnMhGrjbLOPjg9xvuMUFOqCD0rs99y+jR4xQ4AMK9kE2SVJ8j88
	 vr0qvHZrcosA5i7D/KsvAkeZxvh016DI7/h1qHS87UPxKgHzvPREG9ugDHYFt17u0h
	 otT7y//sAhkpQ==
From: Jonathan Corbet <corbet@lwn.net>
To: Kairui Song <ryncsn@gmail.com>, damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Kairui Song
 <kasong@tencent.com>
Subject: Re: [PATCH v2] Docs/admin-guide/mm/damon/usage: fix the example
 code snip
In-Reply-To: <20220823114053.53305-1-ryncsn@gmail.com>
References: <20220823114053.53305-1-ryncsn@gmail.com>
Date: Thu, 25 Aug 2022 12:50:29 -0600
Message-ID: <875yigyx6y.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Kairui Song <ryncsn@gmail.com> writes:

> From: Kairui Song <kasong@tencent.com>
>
> The workflow example code is not working since it got the file names
> wrong. So fix this.
>
> Fixes: b18402726bd1 ("Docs/admin-guide/mm/damon/usage: document DAMON sysfs interface")
> Reviewed-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  Documentation/admin-guide/mm/damon/usage.rst | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

I've gone ahead and applied this, thanks.

jon
