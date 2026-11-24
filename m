Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535592;
	b=uXAl3efcqepMV7HL/lpbjCvHoZy1oUhljM9ifrtjrv0BRJzqGdQtHJQCQgrvNaFEPQ8p
	 QMrXR9owxhdSXBaWh4gY6AYWGrhhQiWWuxBUo6dvg/fzwOrNVqbDRSr/3KW971ayCtqpb
	 vtMS0PgnDZEDRzK9f2WzDmRJpLtK7Q7RDqkfO9AZ2lzb8mVGyqi+Zm3yqr/KV78JkAnod
	 l1hod6nm1ZsgZN3En13s/1UDQCcs1RT70EfjxPi1qBnJLFUlvlwTi6dUOzoRRzRxvTD05
	 GM2uvotiffnLGhJ7M/NM/ngzGCpt+LMVQknZxe0kH8An+9zQEGjtzfeEcwdRxaeDtkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535592;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=W92S3NXXFocy/5kLH13Hgsrgztna4nNYfwUIulhMkrg=;
	b=b8jUw8ddkBCbJYsXVd1rfEg+sJPoBi0tE8zTQZt1DN23LYGgpRMkh7X0NOg0BsThTUDS
	 7tmr/znznLxbBxdea22kOTUAR2kWw0ur9znhIqqhKyuVrm3P2H2aZAF/PSWPQg44O1i/R
	 t64lODz7r/qIAYTTH0XGxBlLA2cuZ/JDuaqg95SpL1o5ndCKwrjRws18ugqDE8TKBOdwK
	 8C6WY/LHmTyjWpuPhgPQ6H2Sj6ElclvO1F6c0af/g7rZSkoiN8IVWpHaeBd5cYPR1ZWKa
	 nL5ixeYE0e8zzqGeNuNrdu275IKB7QW2E3Osb+rzczKRsEG2Of5qnqq4gw7bVkvul0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l6QIaWyb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE67B606A31E
	for <damon@lists.linux.dev>; Tue, 24 Nov 2026 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l6QIaWyb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDF61F000CA;
	Tue, 24 Nov 2026 15:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795535592;
	bh=W92S3NXXFocy/5kLH13Hgsrgztna4nNYfwUIulhMkrg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l6QIaWybWCCHn2gpDlqDc8SuSgf/ggwYoIbtc4RiJgXDkey61PuequVMXhBcpD8yb
	 2X22RfDPFZ2PGEJNo8DMjExlLwkHHJw637SXEAr65rExCHj8KL211k55rA0gtd084E
	 9dsH43WS44OwY5FQLFowc7Feho3Y+7AZ76FqD81pOeKmAsDFLQmkaBxwXpTUNbd9Ij
	 XhgTACdNKnxQeyBO66CBKauvqSXmfXWGRWf/+4c+wdakYPPDEhzV4SGvIxVsaj2CE+
	 m0lSgP8lidIIid1CEtG7YBNCOgiVia0mcs9W9YgoYqPv3+zitynbULpG+AEZnjWbdo
	 U47Me+LxSEKGg==
Message-ID: <sashiko-outbox-231486@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 00/27] mm/damon: let users report their data
 attribute findings
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261124153636.91854-1-sj@kernel.org>
References: <20261124153636.91854-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 15:53:11 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

Sashiko has reviewed this 27-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124153636.9185=
4-1-sj@kernel.org
