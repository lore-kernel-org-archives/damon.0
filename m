Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E659475
	for <damon@lists.linux.dev>; Sun,  3 Aug 2025 18:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754244071; cv=none; b=KzFrTyFi8ExF9oklmV8v494bBOVCQgOc/OzEfZ882TOVYeNntrxF74iAv/csaNyKXFg/9pyXCScRQ4GwqZe7EnmWtjrpKuf0a2U/GVNFjvJgnoHhMSbb4WqmSeS0iCbKBbZScU3hWPenzvb13KToQQ7SXE7ufP3K0zedEmZ2ezI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754244071; c=relaxed/simple;
	bh=1+srFKL5LqQUBE4GwEXD1v1Xs+lZWuUYAffO+amh/XM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QCj/lijJRg12WY/fdM4CuBVLuntDb5EYLI2hgG33EQMDziHEn1lDUmzexjnFSLnh49i8wqjE3Palmr/oTMRnM2j5FEGp5ineYRz9jn+0wP5If9OzBIU83GiH0RQAY6e5SVBFemUVLGcykDKig6xxAG66ietxo3rxAVTjgtwfBTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXUhQcT+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXUhQcT+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC25C4CEEB;
	Sun,  3 Aug 2025 18:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754244070;
	bh=1+srFKL5LqQUBE4GwEXD1v1Xs+lZWuUYAffO+amh/XM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TXUhQcT+ugcm5eT1xOc9y5+zk9JC/OFlH4LG6kssruOF4S/UiB6QcmQSbH/bAfimq
	 QcLBkrzzDmQXE3o73LC4M0AG2r9gL+2CTY/Xylgf50MCoZm1s6z5cfxB7bfGrkRsH7
	 ScsiNM/oKRN4YIsWDbV08YQUw7z3py4EVvQ+unh5rYxeRkHcQeZvMhofRhB5iAm+M6
	 FPycvMxT2hz0SA/UFj+G2V3oy4DoJk7S+J3Wbuki/8ah0pAbcgWktVoZ7u4sKDCmYH
	 7rjtTOJKDbMQJx7PHujyg2OoAzQsCQwIJttYTJd5s11Rk+9/93CbmRkAVe3n4EPygU
	 fAKv4qNwE3O8Q==
From: SeongJae Park <sj@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Bijan Tabatabai <bijantabatab@micron.com>
Subject: Re: [PATCH] mm/damon/vaddr: avoid unnecessary migration between target nodes
Date: Sun,  3 Aug 2025 11:01:07 -0700
Message-Id: <20250803180107.56197-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250803130028.162537-1-akinobu.mita@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Akinobu,

On Sun,  3 Aug 2025 22:00:28 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:

> This change avoids unnecessary migration by checking if the folio to which
> the migration is applied is already located in one of the target nodes.

Each folio will get a single target node among the target nodes, based on the
weights of targets and the virtual address of the folio.  So skipping the
migration because the folio is on one of target nodes can result in wrong
behavior (not doing required migrations)?

Also, a similar purpose optimization was already made by Bijan.  I guess you
aware of that and therefore Cc-ed Bijan.  Could you further share differences
between this and Bijan's one, and measured additional performance gain from
this patch, if you have?

[1] https://lkml.kernel.org/r/20250725163300.4602-1-bijan311@gmail.com


Thanks,
SJ

[...]
