Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795367191;
	b=5NNSMtSr1oziuVFFbJtyoFYaDrw4XFSv+iEp283k7Ynm3uKW6irGk4jhRBao6/xSAsrO
	 sOEBXAsefUzsTvFn4BKkBsCy4u6pRM+a7RrkeRUTD6AgkvcwSB9OPTH6zib4hjcD2nZ28
	 ZwNghb9KdKvPoXV1iZHqHPvrVFFf0AcjugDMOXj6F8GYgCNPz0yKSBg7ImtP7qlgny/6b
	 RJDgZKQGIEa0mBja9+83KSxK6oWsjVPFZR+90G4eul4FkA9mxE14gOSPOhMxWRY8SqXuo
	 FdebM1AiGtHGonzToi/MlE4Cwgvb/+xrCyLM4fqu3zcAylFQEWlSoRsTaAx1vDPUVzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795367191;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0Iax/H9eM6bJ9OYDTw245+vI6UeqXSEZBoVBCTMrZRU=;
	b=Q8r7puQZJaCIJcZcTsXVOIXeL7VXG9YyGxY69SQe8xAJK97QUUh1RTB2hjgytaTw0ow1
	 xAC9sCcoJZHjZYDhuej6KPefDkjfs+M3sq3FoTIwyjV/mC7O9+I4REtxt0l5r+/u5tjJ4
	 k57ZWBGGtsUPm0xGiiQaX4ncfcCGolSUSXwhWDSfogyBxxdDVIzpKfgD8/k6fRK6g6Baa
	 lmVV7MT18bfwqA1gub4ISBq2CFx85v9zy2XvQMhuCocZ4TVYG0NIOJsJoitFrAzc7ONjG
	 WXsVv5pPVk+POBuSz1PIbhgFo7EnDS4Nk7miER1oeud43+HLr9wpATa/55Ig9v7dK0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k7OuNNoQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D14606A320;
	Sun, 22 Nov 2026 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k7OuNNoQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9601F000C4;
	Sun, 22 Nov 2026 17:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795367191;
	bh=0Iax/H9eM6bJ9OYDTw245+vI6UeqXSEZBoVBCTMrZRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k7OuNNoQRod7wVPVdlpf5pY0qocEOnlCldyr8WDlYVxj30CFKX61Dh+chf7KSIhiE
	 l7W8ujdWiBJ96lrdyg0ANOxAuPJG07p6WnJxmj/HqXphw0rMe0XAlE0mqMIjADcnhb
	 t3MlZ8RJdlZsVvi9d+5m3WnZ0bZdFWRCcR4u/VmeUd3bCrkPZUGOy6KidXLH6deiie
	 iEWsCP/AZxYjuKTw/0SwZPQNbNuCMPvpP30lb8t1gdI7knBmbxGIMP/6qLjAFxp/uq
	 CsLw4biMnd7WphugIj1Y/EoIsCCcPesL/nFUwxWhQaPDV0OuDg2EsVM6hBppug1J4a
	 YxxZSt8+jGKFQ==
From: SJ Park <sj@kernel.org>
To: Lian Wang <lianux.mm@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 00/27] mm/damon: let users report their data attribute findings
Date: Sun, 22 Nov 2026 09:06:22 -0800
Message-ID: <20261122170623.152931-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261122143011.85844-1-lianux.mm@gmail.com>
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

On Sun, 22 Nov 2026 22:29:52 +0800 Lian Wang <lianux.mm@gmail.com> wrote:

> On Sat, 21 Nov 2026 12:59:44 -0800 SJ Park <sj@kernel.org> wrote:
> 
> > Build a system for letting DAMON-external entities report their data
> > attribute findings to DAMON.  Let users report their data attribute
> > findings to DAMON using the report system.
> 
> Hi SJ,
> 
> I'm reviewing the series and setting up the tests. I'm also working on
> follow-up test patches for the report queue and its sysfs interface.
> 
> My schedule may be a bit tight this week, but I'll follow up here as
> soon as I find any issues.

No rush, looking forward to issues or comments!


Thanks,
SJ

[...]
