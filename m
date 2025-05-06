Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1CB27FB36
	for <damon@lists.linux.dev>; Tue,  6 May 2025 12:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746535929; cv=none; b=j6xcvgh+/KDPuphuHlCcWXAm/iJUy0Ksc1keY8JXmRz9izxsZZDCr+c2VV+s9I4ognskX45D2XSaeSa/wJCAoEHyBdJH9SXj2/7qkUnw8zsdtQNXMGYHsIjha6d7Bk3xlIuIbUrriGBwBnbjmQFs9r/QYkbljt6Wp4ggIYA0oHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746535929; c=relaxed/simple;
	bh=LTmL5l1/O/8SNcIW+Ggf1eHlEo3C0g8QGNiXUA9s8Xs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sLWWnj3RophEIYp1FGQrweXEEjwZmoDJ4D6dYik7I7ieddH+OFlMMtN4BXrJ2wv8O/6JD62+YO7hnLvPPZTK5HzcaMA647jvcPiqgrU1GQ8Q6WAvNbwx5JWaXe4ZbcaTIJmKfpMiWs7zv50602lIrQ1uxx8C1WEH/ohYRflQF0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=IuM8Ogbf; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="IuM8Ogbf"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 92B57403A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1746535920; bh=WbuvgCrt95UklJ8yYZyIro9wtfbWBve4JKZ5dUw4Lkg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=IuM8OgbftiGfgKwWAf8i69XwSQwd+ZCxS1BzmU0fw7I+XhXIjJoNJZsjGxSeKrith
	 tjq8DQlU1+4KS3b8dc62w7+Sre25f8nUaDmbAGDaU7HxJmgvrmES0/rEAsoNdacig/
	 chQCKgavU20HnKHbUwi3M3naAgsb/eMPaZAIbbwdqVGf4BpU6ENl2wXhTqI1ifAixR
	 f06s1ErsBydLLSMCg+cj6ebrIRykJCkufhyvjytTXc6vfo+J8taQHVzIi0Jp7BrW1u
	 KLXDfiGtMuPK/u9E804MgTJS67rs91BX7XU/H9rCgupOJPostLkWfNVq1uDz7hnvfo
	 Gd7KyCecY6Kfg==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 92B57403A7;
	Tue,  6 May 2025 12:51:59 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: "Thushara.M.S" <thusharms@gmail.com>, sj@kernel.org
Cc: "Thushara.M.S" <thusharms@gmail.com>, linux-doc@vger.kernel.org,
 damon@lists.linux.dev, skhan@linuxfoundation.org
Subject: Re: [PATCH] docs/mm/damon/design: Fix spelling mistake
In-Reply-To: <20250505185350.10171-1-thusharms@gmail.com>
References: <20250505185350.10171-1-thusharms@gmail.com>
Date: Tue, 06 May 2025 06:51:56 -0600
Message-ID: <87zffpx5oz.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

"Thushara.M.S" <thusharms@gmail.com> writes:

> The word accuracy was misspelled as "accruracy".
>
> Signed-off-by: Thushara.M.S <thusharms@gmail.com>
> ---
>  Documentation/mm/damon/design.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
> index f12d33749329..700847a7ac9e 100644
> --- a/Documentation/mm/damon/design.rst
> +++ b/Documentation/mm/damon/design.rst
> @@ -54,7 +54,7 @@ monitoring are address-space dependent.
>  DAMON consolidates these implementations in a layer called DAMON Operations
>  Set, and defines the interface between it and the upper layer.  The upper layer
>  is dedicated for DAMON's core logics including the mechanism for control of the
> -monitoring accruracy and the overhead.
> +monitoring accuracy and the overhead.
>  

Applied, thanks.

jon
