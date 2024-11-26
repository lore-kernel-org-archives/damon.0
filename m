Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816F245023
	for <damon@lists.linux.dev>; Tue, 26 Nov 2024 08:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732609496; cv=none; b=Mlcp9yDREvdwLpVxxyKCGqkxHzqBKjJISdf5UNeNWi9DRfxm6oT7+MKAbI4Bev+vYhMPxVGpIAKRUkdZ8kjkRhHFgOsattCpFKcOiGKqRRaIL60DHsDyywI27MmM533GCWHB7NLJlDiCrTaUw5hp95xOhGeJYUQkAB1JN2oT6IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732609496; c=relaxed/simple;
	bh=wfwOevp8Not+xqFXsHWDcBF+bs9RRHns3SGuKdPD4tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FmaP5tzSILmMhANv7Jr/zBQQIeuMYI0X/dc3GOeiKcnnSljbroEuFhG8S031mLgDBkoDYF1Vd/t/0ZXcE032X6nqTDRBkOtqWQiBeYlZW8VO0anHL2nA3rOW31wmGjc5VrmV5o9diXv80MUH1DQSg7UrMRjVB3zc/jZeQUrHflM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-8c-674585cb1f22
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yunjeong Mun <yunjeong.mun@sk.com>,
	Honggyu Kim <honggyu.kim@sk.com>,
	kernel_team@skhynix.com
Subject: Re: [RFC PATCH] mm/damon: explain "effective quota" on kernel-doc comment
Date: Tue, 26 Nov 2024 17:24:33 +0900
Message-ID: <20241126082436.1491-1-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20241126002921.50035-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsXC9ZZnke6ZVtd0g3WzWC2e/P/NanF51xw2
	i3tr/rNaHP76hsmBxWPTqk42j02fJrF7vNg8k9Hj8ya5AJYoLpuU1JzMstQifbsErozbr6az
	FnQIVbz/cZq5gXETXxcjJ4eEgInEuzfT2boYOcDsnn+qIGE2ATWJKy8nMYHYIgKKEuceX2Tt
	YuTiYBbYwihx4elnZpCEsECQxIkbR1hAelkEVCXWnZMECfMKmEnMeDqfBWK8psTj7T/ZQWxO
	AWOJeeeWM4LYQgI8Eq827GeEqBeUODnzCVg9s4C8RPPW2cwguyQEZrBJbP04lw1ikKTEwRU3
	WCYw8s9C0jMLSc8CRqZVjEKZeWW5iZk5JnoZlXmZFXrJ+bmbGIFBuKz2T/QOxk8Xgg8xCnAw
	KvHw3qh2SRdiTSwrrsw9xCjBwawkwssn7pwuxJuSWFmVWpQfX1Sak1p8iFGag0VJnNfoW3mK
	kEB6YklqdmpqQWoRTJaJg1OqgbHrQsXf/I03458Yy0Xse1pZqq4R0P5Y4HDGfJdTrru1trcJ
	LZ/p9viUc+PTSzdU3XoiFOqcPXmcGe7Pn9Y+b5U820KRCx9Xhm4qSstj8XtbE8cWve702dLr
	k79KrtbVO10kIPIi30VXe80bs2unUoOLSmXWJWYv1X55tu6qMq+0LXfH2UO/k5VYijMSDbWY
	i4oTAXF3Wiw+AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrALMWRmVeSWpSXmKPExsXCNUNLT/d0q2u6wa+XFhZP/v9mtfj87DWz
	xeG5J1ktLu+aw2Zxb81/VovDX98wWfzetoLNgd1j06pONo9Nnyaxe7zYPJPR49ttD4/FLz4w
	eXzeJBfAFsVlk5Kak1mWWqRvl8CVcfvVdNaCDqGK9z9OMzcwbuLrYuTgkBAwkej5p9rFyMnB
	JqAmceXlJCYQW0RAUeLc44usXYxcHMwCWxglLjz9zAySEBYIkjhx4wgLSC+LgKrEunOSIGFe
	ATOJGU/ns4DYEgKaEo+3/2QHsTkFjCXmnVvOCGILCfBIvNqwnxGiXlDi5MwnYPXMAvISzVtn
	M09g5JmFJDULSWoBI9MqRpHMvLLcxMwcU73i7IzKvMwKveT83E2MwHBbVvtn4g7GL5fdDzEK
	cDAq8fDeqHZJF2JNLCuuzD3EKMHBrCTCyyfunC7Em5JYWZValB9fVJqTWnyIUZqDRUmc1ys8
	NUFIID2xJDU7NbUgtQgmy8TBKdXAyJD81G/TWbbYgwen5lXv3bC9W3lPfy1PjuFWW6e6o5OF
	jNx+nWk8n8EvN8mZ88/PdU6doT1nVimcNA7693nx53IF93774/YTv8wrFN3tLTJt3s2Y6K2x
	3y48PfR88oIcGSWTM3dsY8Rfzzwfuzy2NkNl8aXHoapdmsxHPfnMQ69suP0nyolPS4mlOCPR
	UIu5qDgRANtq0EUzAgAA
X-CFilter-Loop: Reflected

Hi SeongJae,

Thanks very much for the quick response.  I think it looks great but I
have some minor comments so please see my inline comments below.

Thanks,
Honggyu

On Mon, 25 Nov 2024 16:29:21 -0800 SeongJae Park <sj@kernel.org> wrote:
> The kernel-doc comment for 'struct damos_quota' describes how "effective
> quota" is calculated, but does not explain what it is.  Actually there
> was an input[1] about it.  Add the explanation on the comment.
> 
> [1] https://github.com/damonitor/damo/issues/17#issuecomment-2497525043
> 
> Cc: Yunjeong Mun <yunjeong.mun@sk.com>
> Cc: Honggyu Kim <honggyu.kim@sk.com>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  include/linux/damon.h | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index a67f2c4940e9..a01bfe2ff616 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -193,9 +193,13 @@ struct damos_quota_goal {
>   * size quota is set, DAMON tries to apply the action only up to &sz bytes
>   * within &reset_interval.
>   *
> - * Internally, the time quota is transformed to a size quota using estimated
> - * throughput of the scheme's action.  DAMON then compares it against &sz and
> - * uses smaller one as the effective quota.
> + * To convince the different types of quotas and goals, DAMON internally
> + * converts those into one single size quota called "effective quota".  DAMON

Could we use "effective size quota" instead of "effective quota"?
IMHO, it will better give an idea this is related to "esz" in the code,
which means effective size.

> + * internally uses it as only one real quota.  The convert is made as follows.

(nit) "as only one" can be "as the only one".
(another nit) "The convert is made" can be "The conversion is made".

> + *
> + * The time quota is transformed to a size quota using estimated throughput of
> + * the scheme's action.  DAMON then compares it against &sz and uses smaller
> + * one as the effective quota.
>   *
>   * If @goals is not empt, DAMON calculates yet another size quota based on the

We better fix "empt" to "empty" together.

>   * goals using its internal feedback loop algorithm, for every @reset_interval.
> -- 
> 2.39.5
> 
