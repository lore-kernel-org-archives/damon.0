Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6569B163
	for <damon@lists.linux.dev>; Mon,  9 Jan 2023 18:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8720BC433EF;
	Mon,  9 Jan 2023 18:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673289029;
	bh=HQCfjExHsVNbVU5V07LRXzsNiZRcHQX4rgcNmgWNn+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ekvh4iIsqIQ6GVoHVm4thN3+73pRDwghhkwnJMdooRgauK2v8ypGCA8euo1Hdwuy+
	 odwUC+onI9Vz3U5pqKaxD7TfvgPVoStViH1Aj8MXlJAjPvHyAaMbCegJ/neqtzAkQX
	 DC2nPYGcYA4MZG6QNROSn+xKL+5wn3d12jFlsNOZM9TKviXEiyDt9qj3/jAVYciPH9
	 rFu+UUDJMewoERsuNkRS9z7TcDyHXfCBrwI4XLHtz/8SnZk9u+JkSaEXUJWJqcRCtU
	 tE/zEAmdovsr4vYJLvseGqVf1JKFK92T6sHu79sj3d9nIeSV2UZVKG2KkDFVfC5P1F
	 Ft9kUMud2Qvdg==
From: SeongJae Park <sj@kernel.org>
To: yang.yang29@zte.com.cn
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	xu.panda@zte.com.cn
Subject: Re: [PATCH linux-next] mm/damon/sysfs-schemes: use strscpy() to instead of strncpy()
Date: Mon,  9 Jan 2023 18:30:26 +0000
Message-Id: <20230109183026.157393-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202301091946553770006@zte.com.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Xu,


Thank you for this patch.

On Mon, 9 Jan 2023 19:46:55 +0800 (CST) <yang.yang29@zte.com.cn> wrote:

> From: Xu Panda <xu.panda@zte.com.cn>
> 
> The implementation of strscpy() is more robust and safer.
> That's now the recommended way to copy NUL-terminated strings.
> 
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>

Reviewed-by: SeongJae Park <sj@kernel.org>

Thanks,
SJ

> ---
>  mm/damon/sysfs-schemes.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index f0dabe3e2dc0..86edca66aab1 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -353,8 +353,7 @@ static ssize_t memcg_path_store(struct kobject *kobj,
>  	if (!path)
>  		return -ENOMEM;
> 
> -	strncpy(path, buf, count);
> -	path[count] = '\0';
> +	strscpy(path, buf, count + 1);
>  	filter->memcg_path = path;
>  	return count;
>  }
> -- 
> 2.15.2
