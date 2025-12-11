Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7C72BE7C3
	for <damon@lists.linux.dev>; Thu, 11 Dec 2025 21:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765490108; cv=none; b=FT4UIH0uUogvYaU/3VSdCbSkdWIuSme7cXYS1IyXRXHHcEW0+C2YIJ1dznKQYKmWGRPn5dgqbQejZ01QrqZVjxXOudJgwmQnn2wYIbbaGdmhM+Ly6QaD+4p0act00pFieCa8xKGrYdsxX44LG8nF731/l9vyX4cDHWYHHtI4jHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765490108; c=relaxed/simple;
	bh=hGfcfFjrnmx2bgWKo3Tcnh0DMTF0/RC5fJr1aYYKs0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVf+CNRjGt2r/EmZA8YDoKfciBqeE8rR4jMWc706iLZ369PeaOiDWKusT+3vhH5DrLoI3ftpX1i7nyxxeKCb9gmxgU6l1Pn74T5Y7I1Pu8o76z20MJbn5gbkAveZxCCTEmHuRV7+RZ0xsFvW30CpRgdHOYG8mTHyHAkCw+3VmWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmUFqP4n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmUFqP4n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA811C4CEF7;
	Thu, 11 Dec 2025 21:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765490108;
	bh=hGfcfFjrnmx2bgWKo3Tcnh0DMTF0/RC5fJr1aYYKs0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LmUFqP4n6Qbidf48dqGDk/YAJaEqcNcjieo7rsjiVsSLlboHqj92WtRcnjGPoRs/D
	 SHF2FMnigSeBKqy9pam0tDhyfK80U/j9uBZELEBkP3ITWcv8RqQ0ZPiAdePUynPmUx
	 L8wAEB8EHp58FT1Mnq6ZimeFHtYWzzmoovkpwuktFsrVXUbgn5Tsl7kC/NEgaRuqls
	 +HXH/UqC3YsXiXyY1srZo2OVHkOpaeqzTY00djDAEMN0vY3HT60CoFuKYj2Z2+3A57
	 LxJQRiljYddy8a66GSSwDx+oV4JtuI4r77Jt/lYCzPrLGa2ETNbwiDuLOwVLMMIPSu
	 2eIuMgL6TNffg==
From: SeongJae Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] mm/damon: add loadable module support for sample modules
Date: Thu, 11 Dec 2025 13:55:03 -0800
Message-ID: <20251211215504.79014-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251211125614.1242713-1-lienze@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

+ Christoph

On Thu, 11 Dec 2025 20:56:14 +0800 Enze Li <lienze@kylinos.cn> wrote:

> This patch adds loadable kernel module compilation support for the three
> DAMON sample modules.  While preserving the existing built-in compilation
> option, the change introduces necessary code exports and configuration
> updates, enabling these modules to also be built as independent loadable
> modules.
> 
> Key modifications include exporting required function symbols from
> damon/core.c and changing relevant Kconfig options from bool to
> tristate.  This allows users to select between "built-in", "module", and
> "disabled" configurations.
> 
> This enhancement provides greater flexibility for both development and
> deployment.  Users can now compile the sample modules as loadable
> modules and manage them dynamically at runtime without reconfiguration
> or system reboots.

Thank you for this patch, Enze.  Actually we tried to make the modules
loadable, but there was an objection [1] with kind clarification from
Christoph.  In short, we don't want to make DAMON supports loadable modules
unless there is a real use case in tree.  Samples are supposed to be samples,
not real usages.  Do you have a real use case of the sample modules that
require loadability?

[1] https://lore.kernel.org/damon/20231205172307.2310-1-sj@kernel.org/


Thanks,
SJ

[...]
