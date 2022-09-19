Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CCD6AA2
	for <damon@lists.linux.dev>; Mon, 19 Sep 2022 17:03:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E557C433D6;
	Mon, 19 Sep 2022 17:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663606987;
	bh=NUfm1ogzfA53a+kYpQi40Xi8gg99UIL8Bf979QIs08Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RLGM3xcHH6VeNaVsiHjRsajiqehzhbCFNE4XE8Cm9Pp1WA+OroPcxpRm5Rok7flF1
	 6qA/MRW/NQwdDF8QFg6mzVjsk11tw3XtWoR+nwMKbX1Cs+fVBOT0rOdAHgj70mxML4
	 wPBlbyIDfuziNhh4jaha9LXQei3QGQRAM+cz39IDHzdmz16oUjoQg7veraJfk6G5oG
	 Rkb9Rgaeh3DSgvKdLa4NPwV0TMYCd5bzAfc8iafWW8o64P3IXbLZ2DHLQrOTRgNZ7f
	 GenpOKPA8mak+9H0ywUEy3Txra4O+eKK0sSj/GEvTP9Xwvm2dBVTpNgC4RviPbnyZu
	 +RCSTpvkKTwEQ==
From: SeongJae Park <sj@kernel.org>
To: Xin Hao <xhao@linux.alibaba.com>
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] mm/damon/sysfs: remove unnecessary variables
Date: Mon, 19 Sep 2022 17:03:05 +0000
Message-Id: <20220919170305.61335-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220919151201.66696-1-xhao@linux.alibaba.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 19 Sep 2022 23:12:00 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> Just do a little change here, the 'err' variable really no need to stay
> here.
> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> ---
>  mm/damon/sysfs.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 0cca1909bf67..b852a75b9f39 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -1109,9 +1109,8 @@ static ssize_t start_store(struct kobject *kobj, struct kobj_attribute *attr,
>  {
>  	struct damon_sysfs_region *region = container_of(kobj,
>  			struct damon_sysfs_region, kobj);
> -	int err = kstrtoul(buf, 0, &region->start);
> 
> -	if (err)
> +	if (kstrtoul(buf, 0, &region->start))
>  		return -EINVAL;

Good finding.  But, I'd like to let the user know why it really fails by giving
them the error code that returned by 'kstrtoul()' here.  Let's keep the 'err'
but return 'err' here.

>  	return count;
>  }
> @@ -1130,9 +1129,8 @@ static ssize_t end_store(struct kobject *kobj, struct kobj_attribute *attr,
>  {
>  	struct damon_sysfs_region *region = container_of(kobj,
>  			struct damon_sysfs_region, kobj);
> -	int err = kstrtoul(buf, 0, &region->end);
> 
> -	if (err)
> +	if (kstrtoul(buf, 0, &region->end))
>  		return -EINVAL;

ditto.

>  	return count;
>  }
> --
> 2.31.0


Thanks,
SJ
