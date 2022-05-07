Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC09E7E
	for <damon@lists.linux.dev>; Sat,  7 May 2022 15:38:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4906C385A6;
	Sat,  7 May 2022 15:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1651937915;
	bh=Wfq0ofKjflL6FDfAc2ySHMaLxEvuR11XDeLIOPWWcv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bQSrY3gHQ+6F4Haq2jQjgWx4GzNwPGzs7Q4P/XGq76ZfM/u7dognkIMLNPEWg/Fn+
	 zrzGQF62RmDVHa0ZuIz+Seq3Zvt+/tb7c56Gew6XB5Z9gPsOiO53pYW2laWTTHes21
	 KpjhikTKaBOZOZF8Hs6vHfJl2mRba7+oIQssVAFtj5LnjLifMsOHSU2PQK7dpm8PAK
	 DWJpM9SBCZG8olW0XBvZOW3rZ4XYFPbD6rSrTodqxGetVY/7yJiCbXJyyx4sFSSrp/
	 pfxqMZWnaIXxcI8Mjq/gDFKYYNYzbgq+/SLh0dDPxwoiU6thcTGYC+eUOxWdTLZjVz
	 JqmVDlF2WWGrA==
From: SeongJae Park <sj@kernel.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Abaci Robot <abaci@linux.alibaba.com>,
	damon@lists.linux.dev
Subject: Re: [PATCH] mm/damon/reclaim: Use resource_size function on resource object
Date: Sat,  7 May 2022 15:38:33 +0000
Message-Id: <20220507153833.45600-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220507032512.129598-1-jiapeng.chong@linux.alibaba.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jiapeng,


Thank you for this patch!

On Sat, 7 May 2022 11:25:12 +0800 Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:

> Fix the following coccicheck warnings:
> 
> ./mm/damon/reclaim.c:241:30-33: WARNING: Suspicious code. resource_size
> is maybe missing with res.

Nit.  I'd prefer having this kind of program outputs in commit message be
indented and not broken, like below:

    ./mm/damon/reclaim.c:241:30-33: WARNING: Suspicious code. resource_size is maybe missing with res.

> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Other than the nit,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  mm/damon/reclaim.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index f37c5d4b27fa..8efbfb24f3a1 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
> @@ -238,7 +238,7 @@ static int walk_system_ram(struct resource *res, void *arg)
>  {
>  	struct damon_reclaim_ram_walk_arg *a = arg;
>  
> -	if (a->end - a->start < res->end - res->start) {
> +	if (a->end - a->start < resource_size(res)) {
>  		a->start = res->start;
>  		a->end = res->end;
>  	}
> -- 
> 2.20.1.7.g153144c
