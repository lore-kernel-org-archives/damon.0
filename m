Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA72E2F7EE3;
	Thu,  3 Sep 2026 01:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788398651; cv=none; b=sed691iCO1s591j64Wxx7vI7eYD/bwn2gGFYtqGuftSjM38F+RnDcaSSb403cbYnFayfJn0iLHMZHUCn4p0Whh/mE0EGFfQkqbk2wNJBsimoPQo60FwS0odmwuSA0mcv+m8tTE5IxLS/dWrSUz9WeHDBhP6drqz+c9X6rI/Glx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788398651; c=relaxed/simple;
	bh=dgo8gwEl4azEE+l+Ovi/8X6rFqOkCdfkW/wmZuI9p5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hw/uqFkAq4dJkLXUlOm+4kSA/C5ssnV5g9EBuf074fPm1yIDFspm7pptKlZNCEBBh/FXpNLfckjNg3qXyZwbkCYBMN/lJiW8hVCvNziOiqymUy0cvH26m7K6X21mXAo4eTk6OLJpWzygruE5OKCn5bu6TsgCN7+ghvxSVzJGgUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZO2d/zgA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZO2d/zgA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BF81F000E9;
	Thu,  3 Sep 2026 01:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788398643;
	bh=g4/wzRwhzlP7/SPH3k5OSlfA54gntiBoho4GKMTgNCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZO2d/zgAos3QFBKX10N0ADQbrGJityoIwfR+nZ1lxEB7TcWhBiMqgwdwQYomqoZtg
	 ns5EuDCb4blPuPUmM0GDc66jt1JeRgtLgdGmFuSHRp7VgiRrX/ZkDJSHjbWFYdIBMf
	 cL4fnuWnAqKRBBJARNSvIX/TRBEAwQ5765Vr7xN4His/89rqNXmevsTFHS5JgL8pBd
	 VUxnAzzBIzZ9dGr4Pl/EPa/oheqeZ4LGTNQ1ARB0QEs7pH6qAcUG/2HurcqovZL5rV
	 eTC3b4m/ss1FjKB+qkLQMmCt/7KzDIjkVxyIBrn/UYFe7iWY3uqlQlJhzs4bUFn3c4
	 xqe2yUmulizgA==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/4] mm/damon: allow NULL or unstarted damon_ctx parameter for damon_call()
Date: Wed,  2 Sep 2026 18:23:55 -0700
Message-ID: <20260903012356.95094-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260903010334.93622-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  2 Sep 2026 18:03:29 -0700 SJ Park <sj@kernel.org> wrote:

> Callers of damon_call() should validate the damon_ctx object parameter.
> If it is NULL or never damon_start()-ed object, damon_call() could
> dereference the NULL pointer or indefinitely hang.  Ensuring all callers
> doing the validation correctly has turned out to be difficult.  Handle
> the corner cases inside the core layer and remove callers' validations.

Sashiko found no blocker for this series.  Sashiko sent its findings to damon@
mailing list [1], and I replied to all the comments having findings other than
the absence of issues.  Please read those for details.

[1] https://lore.kernel.org/damon/


Thanks,
SJ

[...]
