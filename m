Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E0C1EEA28
	for <damon@lists.linux.dev>; Sun, 22 Jun 2025 16:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750608866; cv=none; b=asaEfLlwT24zT6HCQ2r0BOfeZiTt+kIUPdwgr6Pfze2A235iLrqccmbvNcUR0c+Z6xbByfSwpzyQ9fJSBNB3jvIhMS1wM8p+B7paS8YQ1LeyP7MKtF0OQZ9eUS0F0ox6RGCLEMfz5yKP98G0fc7AlxWC6FzU1s3aGezndD6799A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750608866; c=relaxed/simple;
	bh=4pHRnQJXUfptxQxwq1SvF+KeLINCGhxIhnKd3EcOKwM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AveLJdoKEz0wkZRAe3SZMdwOP7Z7EXZtJ6bfJqVdl0YWz8NOGyqUgPqW/NlaMwdNiLGR2whp4oyIikUzKUdYoB4rP40oWEyp9AOuLo4q8qkMMAoT9XJN/eY7/vndZyW6CF/Q4N9kODYtI+el6c6GncGwbCxvduXX6o4qFWzRn1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXgM1wZU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXgM1wZU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05121C4CEF1;
	Sun, 22 Jun 2025 16:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750608866;
	bh=4pHRnQJXUfptxQxwq1SvF+KeLINCGhxIhnKd3EcOKwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gXgM1wZUQQNCWZaLZ26CgqvfdJZ/yzzTrW2KeqDVsDJ8+9uwz/V6LZyetWvAOTAX5
	 OtuWujmhSj3EowCnYQR9FC1reQWzjub/+hFrW2Nu5frL0OBUQX8cR2bRh+ZYI8Bk1a
	 Kl8jp0JU0Yog/KGugbHmPRRosoiMB6NUVucG4ix3khUI/ROzB/od9+HAefJIjWiH0q
	 nMevsJwc3nFNFMhsodQxh2trESKIId7sqcB1lQn0oabHxbknkxL3y0x1hCtmo6BGtR
	 57mpPmdRlxrYTOPgwN3TUL+6piDrMxtW+1f3JMp92i4VRh6QnDYSW+rntx9GM5V2vC
	 YR/QZwYE5oYsg==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	Yunjeong Mun <yunjeong.mun@sk.com>
Subject: Re: [PATCH 2/3] samples/damon: change enable parameters to enabled
Date: Sun, 22 Jun 2025 09:14:22 -0700
Message-Id: <20250622161422.50852-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250622120926.1712-3-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Honggyu,

On Sun, 22 Jun 2025 21:09:24 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> The damon_{lru_sort,reclaim,stat} kernel modules use "enabled"
> parameter knobs as follows.
> 
>   /sys/module/damon_lru_sort/parameters/enabled
>   /sys/module/damon_reclaim/parameters/enabled
>   /sys/module/damon_stat/parameters/enabled
> 
> However, other sample modules of damon use "enable" parameter knobs so
> it'd be better to rename them from "enable" to "enabled" to keep the
> consistency with other damon modules.

I think this is a good change, thank you!

[...]
> 
> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> Cc: Yunjeong Mun <yunjeong.mun@sk.com>

I have simple comments about variable names below.  If you address it, please
feel free to add below.

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
>  samples/damon/mtier.c | 16 ++++++++--------
>  samples/damon/prcl.c  | 16 ++++++++--------
>  samples/damon/wsse.c  | 16 ++++++++--------
>  3 files changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
> index f3220d6e6739..cb273bf4b5c2 100644
> --- a/samples/damon/mtier.c
> +++ b/samples/damon/mtier.c
> @@ -33,14 +33,14 @@ module_param(node0_mem_free_bp, ulong, 0600);
>  static int damon_sample_mtier_enable_store(
>  		const char *val, const struct kernel_param *kp);
>  
> -static const struct kernel_param_ops enable_param_ops = {
> +static const struct kernel_param_ops enabled_param_ops = {
>  	.set = damon_sample_mtier_enable_store,
>  	.get = param_get_bool,
>  };
>  
> -static bool enable __read_mostly;
> -module_param_cb(enable, &enable_param_ops, &enable, 0600);
> -MODULE_PARM_DESC(enable, "Enable of disable DAMON_SAMPLE_MTIER");
> +static bool enabled __read_mostly;
> +module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
> +MODULE_PARM_DESC(enabled, "Enable or disable DAMON_SAMPLE_MTIER");
>  
>  static struct damon_ctx *ctxs[2];
>  
> @@ -160,17 +160,17 @@ static void damon_sample_mtier_stop(void)
>  static int damon_sample_mtier_enable_store(
>  		const char *val, const struct kernel_param *kp)
>  {
> -	bool enabled = enable;
> +	bool enable = enabled;

The local variable is to cache the old state of the parameter.  Hence I think
'enable' is not a very good name here.  I'd prefer naming the local variable
and similar ones on other sample modules as 'is_enabled' or somewhat else that
better represents its usage.

[...]
> diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
[...]
> @@ -112,17 +112,17 @@ static void damon_sample_prcl_stop(void)
>  static int damon_sample_prcl_enable_store(
>  		const char *val, const struct kernel_param *kp)
>  {
> -	bool enabled = enable;
> +	bool enable = enabled;

Ditto.

[...]
> diff --git a/samples/damon/wsse.c b/samples/damon/wsse.c
[...]
> @@ -92,17 +92,17 @@ static void damon_sample_wsse_stop(void)
>  static int damon_sample_wsse_enable_store(
>  		const char *val, const struct kernel_param *kp)
>  {
> -	bool enabled = enable;
> +	bool enable = enabled;

Here, too.

[...]


Thanks,
SJ
