Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D17D2BEC5E
	for <damon@lists.linux.dev>; Mon, 23 Mar 2026 07:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774251254; cv=pass; b=l25rLcVmQUkhUBnu4NHAYjBiTlnw/bCUn1Q95o4cRrTJaBTQeU/IbvdOR4Pre6BGMF4xv7y2R/7IiBkSTVg7AvZCB0RR1glbnglWk23pBgDrwJ2qpjNjeeigKbZoi9h0n2YUkB9crxnAznl47CIJz3kpSc73BSWL7kNyNCiA+Nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774251254; c=relaxed/simple;
	bh=N03MwYZKfJyz/jISI55XQbpuxlLeDNyC93LJJN41uQE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=RypO2RPS3DwLuTVzkp+tQ+yGNOb8U4lEOy4HbpWkEc8HqDW0Tf3VkJ9qE9tIXDfHs8UtyAWvQClVrdmWeA+GrwC66dOzf6HUVwaaq57GX9Lk8jPFTK0XFOMhLfNh2bbGq0Z7csr+ttjCci4J+3ztQ+a2HHJUzzaFM/4Ikp62pDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=aueLpHc3; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="aueLpHc3"
ARC-Seal: i=1; a=rsa-sha256; t=1774251241; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=aLUnjvWbgEl7I0JC+aTZBN+fnPPMFfI8i2jdvaFHgh5TwmGuoWcUJl9PraU6SDZucBuH+quJLOxU4R220FB67UjVk5EKVdZ//jJ7oWwI25ucQdZBlKPBGjKsNzqympd2iJWQg5kT1xu6HFVCLSlvhmfy+6xt/lGt9p4ECl6ANdM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774251241; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=N03MwYZKfJyz/jISI55XQbpuxlLeDNyC93LJJN41uQE=; 
	b=UsIXLyFsu3TmM6YipQqXh4PLYMyOlC3w2LFD/AAP12265oYV9Z+/RVYn97TJcSx7wXjaBDwcP2kau/952bfAwxqCebMzM/AVtS/h2R5VuVYvieJYk3HEwvv8rG1mWVXgn11A4AHaBtsB379jY+rOv/AMjy2FWfPPOE0R7x9l/fg=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774251241;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=N03MwYZKfJyz/jISI55XQbpuxlLeDNyC93LJJN41uQE=;
	b=aueLpHc313GbcC2+GHpnpX7AB8MaxMKRGWEyBqVAqnnPpOPl3doxlTyG9LAMYlAl
	J48cJ90xKKPp0YBNUkAxvhIw5825eueORi81Hxh0sBxkVCxZYt1elHLjhnyW1NaKPgA
	/veyPTzho3WrAo4OferEZ8feGHBtzHo/vdrTJSnc=
Received: by mx.zoho.eu with SMTPS id 1774251240068390.417387203978;
	Mon, 23 Mar 2026 08:34:00 +0100 (CET)
Date: Mon, 23 Mar 2026 07:33:59 +0000
From: Josh Law <objecting@objecting.org>
To: Markus Elfring <Markus.Elfring@web.de>, SeongJae Park <sj@kernel.org>,
 damon@lists.linux.dev, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
CC: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_1/3=5D_mm/damon/sysfs=3A_fix_param=5F?=
 =?US-ASCII?Q?ctx_leak_on_damon=5Fsysfs=5Fnew=5Ftest=5Fctx=28=29_failure?=
User-Agent: Thunderbird for Android
In-Reply-To: <89ab7e7b-ad61-4881-bceb-781481857d3d@web.de>
References: <20260321175427.86000-2-sj@kernel.org> <89ab7e7b-ad61-4881-bceb-781481857d3d@web.de>
Message-ID: <BDDAE837-48DD-4FF8-B7E3-AC0030AF5C9F@objecting.org>
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



On 23 March 2026 07:28:59 GMT, Markus Elfring <Markus=2EElfring@web=2Ede> =
wrote:
>> When damon_sysfs_new_test_ctx() fails in damon_sysfs_commit_input(),
>> param_ctx is leaked because the early return skips the cleanup at the
>> out label=2E Destroy param_ctx before returning=2E
>
>Will it become helpful to use another label accordingly?
>https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/torvalds/linux=2Egit/=
tree/Documentation/process/coding-style=2Erst?h=3Dv7=2E0-rc5#n526
>https://elixir=2Ebootlin=2Ecom/linux/v7=2E0-rc4/source/mm/damon/sysfs=2Ec=
#L1506-L1537
>
>Regards,
>Markus



Markus these patches are already merged=20


V/R


Josh Law
