Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795444084;
	b=DqGVPMo0lhdoI20NzVpGxXHMXA4sODB6FIgiGk8uRAtwH78+4WkDMvV2GY6D9bRVAU3X
	 1g6PmNZYkCwnQbfRzQOag2pMUaeixEhOVC+r+4swJsc5EG6F+s8//9bGENvG0D79BZw2N
	 pYUR4FNes5mab0poXK9NPxWlrFYr43tOkijIo/rxKADl0Ip7/bWN9dUcmPtGXuZjGkNnA
	 2043rSBk9OurjdbBomzK0s2AMd6cMIv4WoVkJH3NwLqI9LBW0EkK8GRJrN0jRqi1A4OBp
	 eGw2JJUOn62TncZW4EHphF3iFHWuuM2TB8k2z7NArertJE2AklWUzPndRLoCxfzMX8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795444084;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kUibffDJu+NILeHG7932dLRGDC9WduDU2Wovc7T9JVU=;
	b=N9vp6kCgtrMm8aZFDvslgUEhm4s3iXSS8sflxCG62gO85WLxRdV6AhUaAXn3H/PTk5ES
	 +b7sDYUBcf2IyyfTmMQEBnll5yIJW6BynCc3XnXZF4/7VdsbyxMwKHw69bazXsPpoGgDh
	 fe890M7NmMp0jZCnZ7dZyuNnA6cnAnMNuBBDOl8fxRiRn+lPHMYSOe3xHznGcaYALCliB
	 gEAg63uOdZ+V7WcM4mCBOYEJ1ZNEall2usPxbZJyCLSx6TPRluoacl5C8fmjm0jKBrPqI
	 Xehq+g1lllhMcaL+RQ2qowyHWnjtNVn+lkwXULdLJDdLVbXenAaaYagc4BkRs189Ylw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hcCpM1qM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9204E606A31A
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 14:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hcCpM1qM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A213C1F000C0;
	Mon, 23 Nov 2026 14:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795444083;
	bh=kUibffDJu+NILeHG7932dLRGDC9WduDU2Wovc7T9JVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hcCpM1qMfibR4i6H9L8GR5F8FivmKW6k3htnsn86kOZtVqPGRZzL0Hm3QfznWjirT
	 JbSkX87kAQJz9Qus6xK0zyANrpLzXt3imH2BbbU3Iejm+S1ftwt3Z6zommNMkCj67T
	 U+I0AjKC6y5iGGEb/rgWr6hl9pesr2famgSNsLVjexeyxfIHWX/ncfjMwb6elE0AC0
	 AST+AUhm+gt2ktMARJPMePwYwGbPRTxKjOkfdf/qq3o99H0GQFo1RbE1R+AkA44kzE
	 K56tDOM5YYswCVLcJqxNRwLbv0WIir8QpbHlPyOezQv3lKrERjcEe1hmCWm1pL/2nI
	 IYmbGYHxvBrcA==
From: SJ Park <sj@kernel.org>
To: Lian Wang <lianux.mm@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	sashiko-bot@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 14/27] mm/damon/paddr: support REPORT_MADE type probe filter
Date: Mon, 23 Nov 2026 06:27:55 -0800
Message-ID: <20261123142756.84068-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123120009.9120-1-lianux.mm@gmail.com>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 23 Nov 2026 20:00:02 +0800 Lian Wang <lianux.mm@gmail.com> wrote:

> On Sat, 21 Nov 2026 13:19:20 -0800 SJ Park <sj@kernel.org> wrote:
> 
> > +               addr_range.start = damon_pa_core_addr(pa, ctx->addr_unit);
> > +               addr_range.end = damon_pa_core_addr(pa + 1, ctx->addr_unit);
> 
> Hi SJ,
> 
> With addr_unit=4096 both endpoints round down to the same core address.
> Could you fold in the change below so the lookup covers [start, start+1)?

Thank you for finding the issue and sharing the fix.  The fix looks good to me.
I will fold in it.


Thanks,
SJ

[...]
