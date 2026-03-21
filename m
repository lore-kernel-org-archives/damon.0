Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEF72561A7
	for <damon@lists.linux.dev>; Sat, 21 Mar 2026 00:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774051717; cv=pass; b=HtsHQQmeIC+PYfFbFWK2/5JrG7RQ0RBUGl7Xpg838RieX2IggOQ9W3d1oZIFmxe6ZNpHUk/oAnwEIw6Eui+xfohts6ymg4J2/cx4o0tarK3jZ78JN++Ow+noTkLBzjEi7wtjU5WbfeoNZXgAXFtlzPhNsEsHyMo+h06QT/rdkRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774051717; c=relaxed/simple;
	bh=SFp00vq4JyybMAbM+n/SB4PkqRpGAMby83rbwLEWzc0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=FRcGtvSSn+0Cvi7K3MYM/9EiXdJQVCcTLCVlQNrSMACKEsLkLfunRywhogsTyOyWoUbIW+B8EZu6+1ajRfJHmxk7oZzR3Xwa5aH/4rQUts2VSR8MZjIgHLxaQL17RT6r4QtYuS3Q+dRe8xLcVDm8yVbBOaYCFdjCalCkQHo79hM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=UFF0HC/H; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="UFF0HC/H"
ARC-Seal: i=1; a=rsa-sha256; t=1774051712; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Ot3VSSaZu3w0EJk2kNRqcxvTnv53LkYqqERkISePoWgewkbjZbAwV3h0F+F+2zyIHcUe8XdLO9DK7O+im/Ktl2D8d51WLN1ROhFKwy3lLynJ5tQ3ywwRNMpqTV42JLsWSYbg+FEomTozA2NUoNR++OWHaA7fI8CEZtWMJ1kwJVc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774051712; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pBghYJ/F/Pt0HxiS5MRMUDhDiTzAi0jLjVNvoL6gXyA=; 
	b=dlUw2tbsGohlZLAfHNQr8yE62OnPQB7Q+BDktR6gZaNFmD/TgTERvxcf6/9AngvudjSElPDlC1BltmoXAqvEs8EtdJLD9VHSmAv/oVIK5xY+ra94dA73UUWF8MR6yglL8VyzxQSD1TSBsCWSkVXFyQClHHXafhukEfbj+nAufuY=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774051712;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=pBghYJ/F/Pt0HxiS5MRMUDhDiTzAi0jLjVNvoL6gXyA=;
	b=UFF0HC/Hr4z/DfDIlT35DNLMP6jx54vRe9xKtJZYe049HIW4Ht9JEjtUrwUyGx0b
	uS9q/yTnXxipvs+OOCfijUZrsVAAowtga3hS6R0ykOSMp51R14d2ifptodqEyWOaket
	6rhjvNL1gHASnDAcY0NE7ga7zSDaugVPDaUCs5Xw=
Received: by mx.zoho.eu with SMTPS id 1774051710629882.7436884050414;
	Sat, 21 Mar 2026 01:08:30 +0100 (CET)
Date: Sat, 21 Mar 2026 00:08:29 +0000
From: Josh Law <objecting@objecting.org>
To: SeongJae Park <sj@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_mm/damon/sysfs=3A_fix_param=5Fct?=
 =?US-ASCII?Q?x_leak_on_damon=5Fsysfs=5Fnew=5Ftest=5Fctx=28=29_failure?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260321000255.102944-1-sj@kernel.org>
References:  <20260321000255.102944-1-sj@kernel.org>
Message-ID: <6902CC73-84EE-4C1D-9FC6-F54C7C378387@objecting.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External



On 21 March 2026 00:02:54 GMT, SeongJae Park <sj@kernel=2Eorg> wrote:
>Apparently this series is only by a mistake, and therefore a new version =
[1] is
>posted=2E  So I will skip this series and review the new version=2E  Let =
me know if
>anything is wrong=2E
>
>[1] https://lore=2Ekernel=2Eorg/20260320163559=2E178101-1-objecting@objec=
ting=2Eorg
>
>
>Thanks,
>SJ
>
>[=2E=2E=2E]


Only the numbering was wrong, like no 1/3 2/3 etc=2E Im a bit of a perferc=
tionist so i nitpicked it

V/R

Josh Law
