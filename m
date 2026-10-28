Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793146202;
	b=tIGl8HoUaHqgGR3/6+QgjRBKPC2xT37c7sZXviNTqOrRPzsgpe8tVReB3DI3PxsmMWwd
	 QF9EjYnoA8oGtQRmZDWxkHhH7XONT9qrzGNIlNR6rGjgHUwjMU7ltZDEqglp5XOmkxmgX
	 JR6QCLGcu1qxSMQgLJ6oSY0KjTdKrFCVEloXrijtz+GI66mUXA/j/X97nvwPz63LP034H
	 WGumliCUI3PFDWvbw4gFvrtRvBTDSMCfRy3XVqlan6578WZ8o7osMpnwueuvNCrROuYnC
	 y4OWxyQUEgpupB/MkyCkIBn3IhkBeHLpBAY57iEh/dbyl4afC7v4oOGrRwdt44/h1VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793146202;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dcj2nzk1x4TQs5h9GEfCeidwdxEiiMerDnsa+sFWmoI=;
	b=CxAlJxzYmF++X/a9VeNzfNkY5LbRT/b2KN4dk8Q5Tm4RzhfRFb34hMGRJqMvGD1T0mzf
	 yYwVhrDLBo2uE//We6t4S5ZmG2EFcDRRu85KtPAF6OsIqqjtppbbz7NRAv8x7D67cEVBI
	 98dE8HcyE7/QCqdXWyNu9PG86llPBmJuG2rZhLcd7y9LIv3cRBDrXmke5h7uqZ/AXhQmc
	 c2HBqqXENTT+vMWe/1pvl4qiVcjFCqo+UHU8iD+uTbF2ecH9mUnAtp777thUDZHFGCZkv
	 jAC85apVP5YM02Y+wqXTq4EvLY9xzgeaji+f7InRls1eLOUVnrE+jA2CJnir+4N6IrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GfmLq0jA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3658606A321;
	Wed, 28 Oct 2026 00:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GfmLq0jA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4970E1F01825;
	Wed, 28 Oct 2026 00:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793146201;
	bh=dcj2nzk1x4TQs5h9GEfCeidwdxEiiMerDnsa+sFWmoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GfmLq0jAcRxZP+ZjJOf7WPSO7CIuv+AESEd8wJMsri2tjnHYAlCzwn+RCmjBRjbQn
	 rxrTYlNOwKxH/TFFTey8pAgJqHujFCYsB9oWuVULFqet4DCULHraLCIhUxEVnhJe2w
	 lU+L686Kv3kjmTqJHCczLJTTM+kWrlW0nwmw1kDR+zPltovBpRlbNblh8ivVcELgNm
	 swCIcOgJVPR0nYlX2l//FghDknWFQSUJpBFFjecGpF0lp+K6Q+fl6eesAQ1QZKWkrV
	 eQ51gDx+6sG735SVXVfU6XfludlkHgjQBAuTCtSpv6Lk/T6h3o8gQUssGUHR/Fa37l
	 1NMFMEy2+owYw==
From: SJ Park <sj@kernel.org>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: SJ Park <sj@kernel.org>,
	corbet@lwn.net,
	damon@lists.linux.dev,
	jm5905938@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	rdunlap@infradead.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v2 2/2] Docs/admin-guide/mm/damon/reclaim: rewrite complex parts
Date: Tue, 27 Oct 2026 17:09:53 -0700
Message-ID: <20261028000954.157268-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261027190628.2527100-2-manuelebnerli@mailbox.org>
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

Hello Manuel,


Seems you sent a new version [1] of this?  I will skip reviewing this.

[1] https://lore.kernel.org/20261027212345.2586628-2-manuelebnerli@mailbox.org


Thanks,
SJ

[...]
