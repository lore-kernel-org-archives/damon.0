Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF333033DF
	for <damon@lists.linux.dev>; Thu, 23 Jul 2026 01:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784770948; cv=none; b=u0AU8l/Mo0ez0b+rq1WmZSAQ2MrxjbI6Z8Dht7j9XEsMpdEh9wTzxQxm4zL7uIN+5hvO5Q+M/9cZtMjrcH5ab8nZkRkhKdUkPXTJhC+qjDz0Te9zLissjGa9tNbD0pe6i3Nkl/gE9G9AQE5/MKTcDI6js+mxDSoTtpCNNrl27Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784770948; c=relaxed/simple;
	bh=9NZO5vfb3zQw2FNfkrSHu7SGXFybx4Car/nQQwH6e5g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=acfBZJDCsZ6HneLNwVykrCqTZhy4OA+4AJKpXWaB4gZ9S5STYfzfntKn8doaJW1xE8hzYQaLCj/chNUfeS8PQzKb+xx9zQYZkDlJZAUYYJsnqpjP39D15Qf07D3Rmw3OjS9oqbLnNB9U6sZysBeGeYt1vLODE7w/aDbx1bHJdmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UWZDw2Rv; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UWZDw2Rv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=9NZO5vfb3zQw2FNfkrSHu7SGXFybx4Car/nQQwH6e5g=; b=U
	WZDw2Rv5jWDft9SO4ijUypbL85nfz9nVuVs65a4vB27OpdTSgOuRQVaUPLgMrg0n
	XzF9XV5YiP9yENkvIEvk9+glwhfNSUkUZymZYU+78KVuj/bNcB5XUXlXzlPlaGDt
	eWPxu0QWdJS4thXyOyfFXOTcxkiLOnONPzYco2uLpQ=
Received: from dayou5941$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr-40-128 (Coremail) ; Thu, 23 Jul 2026 09:42:01 +0800
 (CST)
Date: Thu, 23 Jul 2026 09:42:01 +0800 (CST)
From: =?GBK?B?wO7T07roIA==?= <dayou5941@163.com>
To: "SJ Park" <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev,
	liyouhong <liyouhong@kylinos.cn>
Subject: Re:Re: [PATCH] mm/damon/core: reject zero sample_interval
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260722140113.88379-1-sj@kernel.org>
References: <20260722140113.88379-1-sj@kernel.org>
X-NTES-SC: AL_Qu2TBvucv0Ep5yibYukck0sXhOc/X8awuvgn34BRc88EgC7twQEDZGZsD0Hc79OjMDiyrzW1bDZTw8BEUYJpAxFGxtz4z4xwK9Rw4+nI1g==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <51c3febf.14e0.19f8ca30575.Coremail.dayou5941@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:gCgvCgD3X1RqcWFq3G4jAA--.1839W
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC+gppGGphcWpO-gAA3h
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKCgoKCgoKCgoKCgoKCgpBdCAyMDI2LTA3LTIyIDIyOjAxOjEzLCAiU0ogUGFyayIgPHNqQGtl
cm5lbC5vcmc+IHdyb3RlOgo+SGVsbG8gbGl5b3Vob25nLAo+Cj4KPlRoYW5rIHlvdSBmb3Igc2hh
cmluZyB0aGlzIHBhdGNoIQo+Cj5PbiBXZWQsIDIyIEp1bCAyMDI2IDE3OjQzOjA0ICswODAwIGRh
eW91NTk0MUAxNjMuY29tIHdyb3RlOgo+Cj4+IEZyb206IGxpeW91aG9uZyA8bGl5b3Vob25nQGt5
bGlub3MuY24+Cj4+IAo+PiBkYW1vbl9zZXRfYXR0cnMoKSBhbGxvd3Mgc2FtcGxlX2ludGVydmFs
ID09IDAuICBTeXNmcyBsaWtld2lzZSBhY2NlcHRzCj4+IHNhbXBsZV91cz0wLiAga2RhbW9uZF9m
bigpIHRoZW4gY2FsbHMga2RhbW9uZF91c2xlZXAoMCkgZXZlcnkgbG9vcAo+PiBpdGVyYXRpb24s
IHNvIGtkYW1vbmQgYnVzeS1zcGlucyBhbmQgY2FuIHBlZyBhIENQVS4KPj4gCj4+IFdpdGggYSB6
ZXJvIHNhbXBsaW5nIGludGVydmFsIHRoZSBhY2Nlc3MtcmF0ZSBhY2NvdW50aW5nIGFsc28gZGl2
ZXJnZXM6Cj4+IG5yX2FjY2Vzc2VzX2JwIG5vIGxvbmdlciBtYXRjaGVzIG5yX2FjY2Vzc2VzICog
MTAwMDAsIGFuZAo+PiBrZGFtb25kX3Jlc2V0X2FnZ3JlZ2F0ZWQoKSBoaXRzOgo+PiAKPj4gICBX
QVJOSU5HOiBpbnZhbGlkIG5yX2FjY2Vzc2VzX2JwIGF0IHJlc2V0OiAuLi4KPgo+VGhlIHdhcm5p
bmcgaGFzIHJlbW92ZWQgYnkgbnJfYWNjZXNzZXNfYnAgb3B0aW1pemF0aW9uIHBhdGNoIHNlcmll
cywgd2hpY2ggaXMKPmN1cnJlbnRseSBxdWV1ZWQgZm9yIDcuMy1yYzEuICBTbyB0aGUgd2Fybmlu
ZyB3aWxsIG5vdCBiZSB0cmlnZ2VyZWQgb24gbmVhcgo+ZnV0dXJlIG1haW5saW5lLgo+PiAKPj4g
UmVqZWN0IHNhbXBsZV9pbnRlcnZhbCA9PSAwIGluIGRhbW9uX3NldF9hdHRycygpLCB3aGljaCBj
b3ZlcnMgc3lzZnMKPj4gY29tbWl0IGFuZCBvdGhlciBjYWxsZXJzLiAgZGFtb25fbHJ1X3NvcnQg
YWxyZWFkeSByZWZ1c2VkIGEgemVybwo+PiBzYW1wbGVfaW50ZXJ2YWw7IGFsaWduIHRoZSBjb3Jl
IHZhbGlkYXRpb24gd2l0aCB0aGF0Lgo+Cj5UaGlzIGlzIGEgc29ydCBvZiBiZWhhdmlvcmFsIGNo
YW5nZS4gIEkgYWxzbyBmZWVsIHRoaXMgYWRkcyBhbm90aGVyIGNvcm5lciBjYXNlCj50aGF0IG1h
a2VzIG15IGhlYWQgY29tcGxpY2F0ZWQuICBUaGVyZSBhcmUgYSBmZXcgbG9naWMgd3JpdHRlbiB1
bmRlciB0aGUKPmFzc3VtcHRpb24gb2YgemVybyBpbnRlcnZhbHMuICBIYXZpbmcgaW5jb25zaXN0
ZW5jaWVzIGJldHdlZW4gYWxsb3dlZCBpbnB1dCBhbmQKPmhhbmRsaW5nIGxvZ2ljIHdpbGwgbWFr
ZSBpdCBkaWZmaWN1bHQgdG8gbWFpbnRhaW4gaW4gbG9uZyB0ZXJtLiAgQ2FuJ3Qgd2Uga2VlcAo+
c3VwcG9ydGluZyB6ZXJvIHNhbXBsZSBpbnRlcnZhbCBhbmQgZml4IHRoZSB3YXJuaW5nIG9yIHRo
ZSByZWFsIGJ1ZyBpbnN0ZWFkPwo+CgoKCgpIaSBTSiwKClRoYW5rcyBmb3IgdGhlIGV4cGxhbmF0
aW9uLiBJIGFncmVlIHJlamVjdGluZyB6ZXJvIHNhbXBsZV9pbnRlcnZhbAppcyB0aGUgd3Jvbmcg
YXBwcm9hY2gsIGVzcGVjaWFsbHkgc2luY2UgdGhlIHdhcm5pbmcgd2lsbCBiZSBnb25lIHdpdGgK
eW91ciBxdWV1ZWQgc2VyaWVzLgoKClRoYW5rcywKbGl5b3Vob25n
