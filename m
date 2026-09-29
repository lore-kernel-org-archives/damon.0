Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AE7515890;
	Tue, 29 Sep 2026 10:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790678065; cv=none; b=T8x04BsWeTFbomCvfVR9jIyQGCwT7VpyMmV1LPavRwGnuWwfdLUuerJDKvUizkHFt1cMcs4EJYVYBOEsmVQGwsyhPYHZooup+Qo5fdffW89NRkqDwBfGVlbLiPqa16nB0LNkZAy0RVLm+gz70cFdW8KCrgkDQxgnaJrXNa9Iyfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790678065; c=relaxed/simple;
	bh=kSH9iXgw4OzBViyz1Xa2n/YB37FaIuWGJHY131yUYb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lexdnpFfiK86cajJXcHykJZAjgAEjB9fcVQQGjMYQwUQ5tfqzsPj2KCyIPtrxmZ3lQzoYAJmTI1qT2IGiSr7lcV/9ZpDqOyD4gavTecnpzigUDkDoMZa4Vpvr1YrWA00mkOMEQPWyrdpdnUCdo2+dYdVg+yEl1m/ZNHP1KeTDCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkRAZzAA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkRAZzAA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D041F000FF;
	Tue, 29 Sep 2026 10:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790678049;
	bh=yBXkg6lcF7PD3meg2Ejx15cUOLf+061n4vtekQxtgDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BkRAZzAAV8/v/ofwm68pL7D7X30D+pQbx4GcFkSEH39MsIDPvjYEs8+iarX+qTD3m
	 mMYFRfqWksoJomd5y2p/bfyMmxfpZsy8wEiD+kRWxk9dqFY1r0QwF0xFzAszOb24iI
	 kRmvwYdoE5heMF5W1AQrn4P88T8mlyoioR+Ztx3AwTcNMtTXoSAEoK1k834K1KAHHc
	 MOKzPZVDRj/tjwHLLrLCYw1yGuzqSXHRHPiHfZW18i3QRSpJT+zVr3hQBYbGRe2zhs
	 8MoVlGNYutWNuwSP1RHMnEDXsCgOnkhlP+eBBHtJ2tBdjVudqPeCBalzAj+MVvyBp1
	 Lu+IwyjQg0Rdw==
From: SJ Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/8] mm/damon/core: introduce damos_quota_goal->complement
Date: Tue, 29 Sep 2026 03:34:03 -0700
Message-ID: <20260929103404.48154-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <9e07dbdd-3b02-4175-b343-c8cb6f9885e0@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 29 Sep 2026 13:24:20 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> Hi SJ,
> 
> On 9/29/2026 11:01 AM, SJ Park wrote:
[...]
> > +	/* updte current_value to complemented value */
> There is a typo there. It should be "update".

Good catch, thank you.  Andrew, could you please fix it up when you take this?
Let me know if you prefer reposting.

> Also, what is the 
> purpose of this comment? It doesn't explain anything, which may
> not be obvious.> +

The purpose is explaining the code below does what the comment says.


Thanks,
SJ

[...]
