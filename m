Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC7B19B5A4
	for <damon@lists.linux.dev>; Thu, 11 Jul 2024 19:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720727233; cv=none; b=HGsgNXxTDXj0P3WtuxeLH19u+IbXAcvKGaVSzJVEdGaegcMAAMtWJSUVMtmnexNrAx//T6s3LGEaX8aCjCBOUt+55KC3/W8TU8QGtaWr7acLogV4UssuL0SeBVWRb8XnQWsqO0NUTFlSmll4rHDPo3+Ab3jWeN14uzsElImVtRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720727233; c=relaxed/simple;
	bh=rmcD2aNHjLJ4bYvPaO3jrh9nHbq+CEqCZmipMcAWg2w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eGW7Ik1FIQ6P1kr/IqkbKTJ7Dejm2sGAPSKJ2DY3rwOryodAyn6Iv4P4PO9TFvkCIK9YQ7w5bWZ5b2d4sqh09Kvymm5gD1uN+xltYF5KwBNjTzyTl4+kglxYQYxxOBEeAwFoMnUMM8SQOi6FqBA1cUI7vaIvb5+jIhHdmjBrW5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JxL2Fuby; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JxL2Fuby"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC6BC116B1;
	Thu, 11 Jul 2024 19:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720727232;
	bh=rmcD2aNHjLJ4bYvPaO3jrh9nHbq+CEqCZmipMcAWg2w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JxL2FubyyMQzpHlm5UKjoS8LnXJlfQkSdGVSYqWHgRrPSOquWz1unQY2OmnaQXwoW
	 SVH6k2FpcHt4mLj82iyYfI3BniHYaJtScFY/ofnwQT6l1FWo97PTaC2wHeJXjPnoKu
	 kPGFjkoGVcYayzEVxmNtDBrMinLgxZRCuxA1JuUk=
Date: Thu, 11 Jul 2024 12:47:12 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: flyingpenghao@gmail.com, damon@lists.linux.dev, Peng Hao
 <flyingpeng@tencent.com>
Subject: Re: [PATCH]  damon: using pointer to access globally defined
 structures
Message-Id: <20240711124712.4e542d4669517bb093025a66@linux-foundation.org>
In-Reply-To: <20240711184852.431746-1-sj@kernel.org>
References: <20240711081051.66560-1-flyingpeng@tencent.com>
	<20240711184852.431746-1-sj@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jul 2024 11:48:52 -0700 SeongJae Park <sj@kernel.org> wrote:

> So I'd suggest to use dynamic allocation and stub's content copying similar to
> above.

Yup.  kmemdup() should work?
