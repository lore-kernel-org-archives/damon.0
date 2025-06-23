Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342B82D3238
	for <damon@lists.linux.dev>; Mon, 23 Jun 2025 18:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750702305; cv=none; b=T2PfU22SJ0GUpZYfZy5kHv5YsgNE7QaPVMIhC7UFTTFvpegiznSHQq7HtszNcWXq1qaalIrwk5TTzqm4GKiZCfJ2OcVcbtL0TERaWREz8MPkr7hj3vip6RnJpwSmr/Yk42QkxdoHTFri1lbMebuqsde3t3A5jug6t7yVbSvc4nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750702305; c=relaxed/simple;
	bh=U4EcxByI/JbbHyuN2+eaOxfqoB7IHVCK74pv2/kX0F0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XsG/9tPrO/quNQiRCzjR8fkqCottxV+Vn+51EZ08L+b2LULgDLbhafrVDQ4WmSW6WD8Wchlu3vvNQJhcEMuPPK3wq16mILb1vUB/vBkQCXNqhf4eJxUF04shPwWkqby1ph8n72n6m0BoF7hGY0r81Lg+u88xYZJcDU/HYnLLmaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKEWHupG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKEWHupG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE593C4CEEA;
	Mon, 23 Jun 2025 18:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750702305;
	bh=U4EcxByI/JbbHyuN2+eaOxfqoB7IHVCK74pv2/kX0F0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eKEWHupGA09RtMra0hYffapXwJeyZ/zqZPsrp9ny7G47XzRx9esgvaWC7gcjJ78Sl
	 EERoZ4ZIoQN8VAMNFER85cqDeMK2IBoL2WlXAhT8iUg23CoucEbm/GhvJAfQi5tp74
	 cMuXLT8/kiaLRsFP26R043T6Qp1fHI3B5TWq2LN4TcPAyIylz4bBGjSwFyZeQXw5ZW
	 JUTmMVNM8JYed2H+EqlbgIQcnjGE5CfJesMN8kRJ1MNZcs/0HEDCCm+pKmGGeI2SeF
	 Ky+L8Hvcf6xboc3NV+satpb03l/VK0J48vuFkY275hHU/OeKWyjxHWDhKpB11BgGA2
	 sFcCjnIYVYm5w==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	kernel_team@skhynix.com,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Yunjeong Mun <yunjeong.mun@sk.com>
Subject: Re: [PATCH 3/3] samples/damon: fix bugs for damon sample for start failures
Date: Mon, 23 Jun 2025 11:11:42 -0700
Message-Id: <20250623181142.44434-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <f6739a52-eb5e-4a88-9796-b53f18869059@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 23 Jun 2025 12:16:32 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> Hi SeongJae,
> 
> On 6/23/2025 1:29 AM, SeongJae Park wrote:
> > Hi Honggyu,
> > 
> > On Sun, 22 Jun 2025 21:09:25 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
[...]
> > If we want to make stable kernel maintainers' life easier, we would better to
> > split this into three patches, for each module, and add appropriate Fixes, as
> > below.
> 
> Spliting this into three patches is okay.
[...]
> > Could you please do so?
> 
> If we do, then this patchset has to come before "enabled" renaming patch.
> 
> In addition, I remember mixing stable and non-stable patches together in the
> same patchset isn't welcomed by Andrew or other stable tree maintainers.  So I
> might be better to split those three fix patches into a separate patchset.

I didn't think they would really bother such mixed patch series, but, yes,
please do so.  Being nice to others is cool :)

> 
> The only thing that bothers me in that case is writing cover letter for simple 2
> or 3 patches as they are relatively simple.

I think you could also add the divide-by-zero fix (first patch of this series)
to the series.

> 
> But it isn't that hard so can manage those in the next spin.

Thank you, looking forward to the next revisions!


Thanks,
SJ

[...]
