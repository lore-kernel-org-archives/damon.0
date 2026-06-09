Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE94D48A2A0
	for <damon@lists.linux.dev>; Tue,  9 Jun 2026 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781020232; cv=none; b=Cajk3qA2XHHS8tbWeLL0sTIdt/7HWXEMd7/vi5pzixBoNRWMo/OAqom7M+99DWTdg7spqIxsRgNAkWVkYuWEmAqXr6Lv1Ex/mvet+TFBFV48ZAGaIwYfA8MKHCL9d8xKrIUUnOLp0iDSvry5jZImGXS5TDARFOZxqlEmFci0ThQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781020232; c=relaxed/simple;
	bh=Xqrqdax3GvTji0D3s2oXp61F4Ax/hXxDzkBP9MuGAy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VScoJMgsyyGuiNP9TUBemFEGKFLuZ3+TnQl1E31GGerHzP5ixY98a62CV22GP5n+OQb7Pb1+f9QqKrvqjVmuVV0EaBr0cmlBnjNd6hZ0YBfqcuWFyvxxU2rjDr1ZKy6+s6ZVEfnVlW0iLPgB03bNbVnSTwn0DFa7mmK4mMHX7hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q3AXpyJY; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q3AXpyJY"
Message-ID: <ed2a595e-bcc4-4af9-99b0-4029f2a13476@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781020227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m+6fcZSlWOlBCUqWc42EMaBGgUkNT9qApX3XmRXZGo4=;
	b=q3AXpyJYO06/Xzod4bGBw+cxyrlUjodg9xT2dpSd3ijWO8Hh2CTigI8fxhDNAvpIkDvNXK
	kJ6gBlfAJ11djJYYupjiyZ7pszRj9GhYrxI/76L6LIVaq4wYYK8F2zE3KXhdjyXEDwG3fu
	6wTG2CLRA1CYjTYyDwxdj/y50erOyN8=
Date: Tue, 9 Jun 2026 23:49:07 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH v2] samples/damon/mtier: fail early if address range
 parameters are invalid
To: SeongJae Park <sj@kernel.org>
Cc: Zenghui Yu <yuzenghui@huawei.com>, damon@lists.linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 wangzhigang17@huawei.com, liqiqi23@huawei.com, stable@vger.kernel.org
References: <20260609144918.69429-1-sj@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <20260609144918.69429-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi SeongJae,

On 6/9/26 10:49 PM, SeongJae Park wrote:
> 
> I think this deserves Fixes: and Cc: stable, like below.
> 
> Fixes: 82a08bde3cf7 ("samples/damon: implement a DAMON module for memory tiering")
> Cc: <stable@vger.kernel.org> # 6.16.x
> 
> Other than that, looks good to me.
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>

Thanks!

> 
> I applied  this patch to damon/next [1] tree.  We are now quite close to next
> merge window.  We (mm community) want to focus on making mm.git more stabilized
> and therefore ready for the next merge window, rather than adding more changes
> that are not really urgent.  I understand this series is not really urgent,
> because it is causing only DAMON internal weird behavior and one time warning
> on debug kernels.

Yup!

> 
> Hence, Andrew might not add this patch until next -rc1 release.  In the case, I
> will request adding this to mm.git after next -rc1 release.  So, no action from
> your side is needed for now.  Let me know if you think this is really urgent or
> I'm missing something.

I agree with you that this is not urgent and can wait for the next -rc1.

Thanks,
Zenghui
