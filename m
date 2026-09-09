Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADF557267A;
	Wed,  9 Sep 2026 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788964413; cv=none; b=tMWOJXlIJgrVwSOwtcK6HbSMS8aYJnwyJVf+lIylWW7+Azwc4DNPMOpE2wXhspQcGY27lP6/lAEbCFgYAq4dxSSsPv+KJ6H9ikafcuywWuZT2hxswTQp0n+cVr4Ad1LCk7z3QBLciNEsLblNJdfWTOVX98JcZbe6IlhFMsn/r+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788964413; c=relaxed/simple;
	bh=TwOU+mL+Fj08kYAhvOrvCisACiHgeIPo5ErNaxC19ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6Gun9pra7BHsIUSIjDRD7Pj57Hl0Z8GvtbIsqzM6nxu5keUVuhiz5CT86b6QbTfeXPkuQGAB8dBQ7K4qawAwWiguixaJwVK7VQCuBQYaNAtyMb7d6dls3mbp7QXDYWdbGwPpo3n52Xi+B9C5tK0g/TAX8eEhD/DbPYR+LBRoGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIxFg2GJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIxFg2GJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0851F00A3A;
	Wed,  9 Sep 2026 14:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788964412;
	bh=uTRdU091dpy9ie1NZayq6OITJdUQdHMACGQ395O9E7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SIxFg2GJ8mdvlSqplV1intOkApf2axIOQmnD5RnflT3gBSrfRJjoEAhQdG8sORshJ
	 dFRxU+gt90nyJOWk8GbNkrNov1IrzR4nPBvUTdNG16hAPstoLI9+lWyDViRry9ionD
	 9c3xgBntebDbwQ6hKpSPLSccz+Jg2kyusKkw1TLlzgYYumtQ7m4evbpYzp8Lv8sVVK
	 UO83RB7cfHJXWJiQ9VedVokOOMVqe3HWibP9e/W3j3L+S0aNkgGGD1Jl3VJItqXNt0
	 O0Z6RR0sOD+yW83uGsCc9HA9kdTCa5rDEbFF1m80WQd0F2Ir9c6RSp3sjx5v6F7l3+
	 v0XkLE9Qp1ERQ==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH REPOST 0/5] mm/damon/vaddr: support {prep,apply}_probes
Date: Wed,  9 Sep 2026 07:33:24 -0700
Message-ID: <20260909143325.106813-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260909140408.104699-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  9 Sep 2026 07:04:02 -0700 SJ Park <sj@kernel.org> wrote:

> DAMON supports data attributes monitoring.  However, only the physical
> address space operation set (paddr) is supporting it.  Add the support
> to the virtual address space operation set (vaddr).

Sashiko found no blocker for this series.  Sashiko send its findings to damon@
mailing list [1], and I reply those if anything needs to be clarified.  Please
refer to those for details.

[1] https://lore.kernel.org/damon/


Thanks,
SJ

[...]
