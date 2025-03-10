Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DB41E519;
	Mon, 10 Mar 2025 16:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741623482; cv=none; b=JpsMbMPEvdocZPDbBAnU1McXqse/TuDMd9VuX6ue1YzrrdyGcgQo3/lSrgh2LtEJCpJmVr2TKSI3yImlRNoPKdGdcYglDlvT+zsF38SAGvAHVAmk6C7iwSQVHQ7L9TveaD/6Cf0ZespEtD/+CAP2T+oOX7Cf1MwpvJLLJUnr3Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741623482; c=relaxed/simple;
	bh=vq8ygBaZQ4+MXV/G1y5C9vDL0QOR/iHg4KIzBe0wSdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AdHvP8SrvsBv8+1pFptlkFAo764ubh7vt6kg6UsN/UEMSjPSHOq5cFANZnnDzmUTzMiwYYAAMvohIwLxlL29hT10zdPPU+VsBeiMC+SUFjvN6rn7ZO46nt6ELaZWOBPPf9VfCoimPoc37gHQAqOmozuXwWOzq/N2ZfRQN20G//8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lybZ1lzJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lybZ1lzJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797DEC4CEE5;
	Mon, 10 Mar 2025 16:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741623481;
	bh=vq8ygBaZQ4+MXV/G1y5C9vDL0QOR/iHg4KIzBe0wSdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lybZ1lzJ1UWUQ+Fc95kJ/jhbkAY6gbiJIDrAM4I0jGXoM8p83jI91Exwra0bZ6grM
	 Nfs0HAtcT57d5YMr3cERPy9ACb+1LIbuey7cyNhcPhPhetI51NKDV5qvcHZ5+gf3QF
	 RA+b0BY7jmSvGG5aRNcL2xFLqLv1mRg0K1pyP/+Ow9k+ImO17zjhJrwEgMgS0E5/Xa
	 Vkt3fXSfyhdDNXeLPAFJ3AVT+/9ILHcugkQmn08oDXbovUmuGQcbkB+mIC5o+wK6Wx
	 lAlthK2NmkIxRChEd4v+gAMRPWq0oiUvqAAdmQw2KgwxYWc0oXkeMvFR6brxdWIxfA
	 EeJZNwczHvr3Q==
From: SeongJae Park <sj@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Hyeongtak Ji <hyeongtak.ji@sk.com>,
	Honggyu Kim <honggyu.kim@sk.com>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/sysfs-schemes: avoid Wformat-security warning
Date: Mon, 10 Mar 2025 09:17:58 -0700
Message-Id: <20250310161758.606151-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250310135142.4176976-1-arnd@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 10 Mar 2025 14:51:37 +0100 Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> This warning is for potentially user-defined format strings:
> 
> mm/damon/sysfs-schemes.c:1664:4: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
>  1664 |                         name);
> 
> Change this to use "%s" as the format and the name as the argument.

Thank you for this patch!

> 
> Fixes: 92bc039dd72e ("mm/damon/sysfs-schemes: let damon_sysfs_scheme_set_filters() be used for different named directories")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  mm/damon/sysfs-schemes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 50e6907515e6..23ac98dd6451 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -1661,7 +1661,7 @@ static int damon_sysfs_scheme_set_filters(struct damon_sysfs_scheme *scheme,
>  		return -ENOMEM;
>  	err = kobject_init_and_add(&filters->kobj,
>  			&damon_sysfs_scheme_filters_ktype, &scheme->kobj,
> -			name);
> +			"%s", name);
>  	if (err)
>  		kobject_put(&filters->kobj);
>  	else
> -- 
> 2.39.5
