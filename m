Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA64746A1
	for <damon@lists.linux.dev>; Wed, 21 Sep 2022 16:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06198C433D6;
	Wed, 21 Sep 2022 16:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663778505;
	bh=TPnWwHt82eNripHM/TYcNEM4j+W6BPqrNNPqcMZfY2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DssCK6+5FXzjyCL6XPkfhP19N3vuzZwpdHEi9FoT3tAIJLv4uLcPmDkU3/ASW5rqJ
	 +LpEimYm461rx6A8qD2Gg/miof6u/D2og2ABIlZkE159gh9yUHyxmZ0h+PCBkEBzOw
	 UkfkGOGijvBa2Y/vGW2GzS41KcT8hN5+t7NKgTFP7ypazxp0b8LLV3elnNvEFV6lC6
	 D+1vcgOVV4v2l0I5E1UEy9pb5Nr+nx1HCzMr/mn8wN2bSir3g+Qu7uk5qYSLlRIHEl
	 mI4Fb40bAXyiaJOce//FWlBxNhlvoM26mBRpn2932H7dIKNyDNklrmpSvAPueagsvZ
	 atpk3RPMiQqjQ==
From: SeongJae Park <sj@kernel.org>
To: Xin Hao <xhao@linux.alibaba.com>
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm/damon: add DAMON_OBJ macro
Date: Wed, 21 Sep 2022 16:41:43 +0000
Message-Id: <20220921164143.59971-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220921034942.88568-1-xhao@linux.alibaba.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xin,

On Wed, 21 Sep 2022 11:49:42 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> In damon/sysfs.c file, we use 'container_of' macro to get
> damon_sysfs_xxx struct instances, but i think it has a little
> inconvenience, because we have to pass three arguments to
> 'container_of', and the codes also look a bit long, so there i add a
> 'DAMON_OBJ' macro, you just need to pass one arguments, then you can get
> the right damon_sysfs_xxx struct instance.

Thank you always for your helps and efforts, but I have some comments below.

> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> ---
>  include/linux/damon.h |   7 ++
>  mm/damon/sysfs.c      | 230 +++++++++++++++++-------------------------
>  2 files changed, 102 insertions(+), 135 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index e7808a84675f..a3b577677caa 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -24,6 +24,13 @@ static inline unsigned long damon_rand(unsigned long l, unsigned long r)
>  	return l + prandom_u32_max(r - l);
>  }
>  
> +/*
> + * Get damon_sysfs_xxx relative struct instance.
> + */
> +#define DAMON_OBJ(_type) ({						\
> +	const typeof(((struct _type *)0)->kobj)*__mptr = (kobj);	\
> +	(struct _type *)((char *)__mptr - offsetof(struct _type, kobj)); })
> +

So, this macro assumes two implicit rules.
1. The caller would have a relevant 'struct kobject *' variable called 'kobj',
   and
2. The '_type' would have the field 'kobj'.

I think the implicit rules could make some people confused, so would be better
to be well documented.  Even though those are well documented, I think it
cannot intuitively read by everyone.  Making the name better self-explaining
might help, but then the length of the code would be not so different.

So IMHO, this change makes the code a little bit shorter but unclear to
understand what it does.  And at least to my humble eyes, use of
'container_of()' makes the code a little bit more verbose, but clear to
understand.  I have no idea how we can make this code shorter while keeping it
still easily understandable, and I think the level of verboseness is acceptable
for the readability.  So Nack at the moment, sorry.


Thanks,
SJ

[...]
