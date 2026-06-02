Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8571E26A0A7;
	Tue,  2 Jun 2026 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780419790; cv=none; b=hT+6NzwHD2emsNdX4HhFN/CoVfKUr2Ac8J+4vX6uzjSXrCOZSPHLXTaH3JZNX1sczdUG6JVt4A3MAVJEBQ+aMR5Y/JQdRA+L1iG7xkgM8+saxasN8KxrKKLdpF1gGUT+4VKkWW7SoxMNNY/jr4X4h2YgsrmMw37WRQRElLWAUVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780419790; c=relaxed/simple;
	bh=xJAhStjE1OKsmxO+jBHGSfr8umVN61hLLBAAPVwFWHQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EFB2BBOH+S5Wvqo+WRjLatL32k/fS9MoGO3dWLy0qgGyXkmk4vU4HYdu/TFe9wabt0gTdDX4hGEgAjGn8+I74XjZy6E/hs1f6lTGmztBNbPvcQeSctkXDdJ3EFJl4Tvd3ax1BJ0zonmfdUUsp9NLpgGs3gccIxMDsUSYK51vQeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Uyho2EqF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Uyho2EqF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDEAE1F00893;
	Tue,  2 Jun 2026 17:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1780419789;
	bh=+Y205+jwxZNt5BZBpRmlKr0YkMQUprP/O1WFroqRwtM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Uyho2EqFf0mnl8glIIaUveTd/kfrqN5xaW+0tW/b/CAYpUeKehQO5szzT68HA52Ux
	 clfQ1lEAM0GAO9O6huQzWizK0uVW19Pbc/1bimYb9dBHtlKEHgvkbotOXLRN1DTRhB
	 BkJMdg2oWyZ/6xj/tYaZecppjUyFXQLlISFKPrcY=
Date: Tue, 2 Jun 2026 10:03:08 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: Ruslan Valiyev <linuxoid@gmail.com>, Shuah Khan <shuah@kernel.org>,
 damon@lists.linux.dev, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] selftests/damon: test kdamond refresh_ms
Message-Id: <20260602100308.749f8ae894efc3bb73fa02e8@linux-foundation.org>
In-Reply-To: <20260602142804.102210-1-sj@kernel.org>
References: <20260602131217.2210912-1-linuxoid@gmail.com>
	<20260602142804.102210-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Jun 2026 07:28:03 -0700 SeongJae Park <sj@kernel.org> wrote:

> Andrew might want us to wait until next rc1 release, though, as
> apparently now we want to keep more time on stabilizing mm.git for the next
> merge window.  Andrew, please let me know if so.

Yes, awaiting -rc1 would be preferred please.
